#!/usr/bin/env bash
set -euo pipefail

REPO="${GITHUB_REPOSITORY:-asakatea/Yaru-release}"
API_URL="https://api.github.com/repos/${REPO}/releases/latest"

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required but not installed." >&2
  exit 1
fi

response="$(curl -fsSL "${API_URL}")"

if [[ "$(jq -r '.message // empty' <<<"${response}")" == "Not Found" ]]; then
  echo "Latest release not found for ${REPO}" >&2
  exit 1
fi

tag="$(jq -r '.tag_name' <<<"${response}")"
published_at="$(jq -r '.published_at' <<<"${response}")"

if [[ -z "${tag}" || "${tag}" == "null" ]]; then
  echo "Invalid release tag from API response." >&2
  exit 1
fi

build_number="$(grep -oE '[0-9]+' <<<"${tag}" | tail -n 1 || true)"
if [[ -z "${build_number}" ]]; then
  build_number="0"
fi

win_url="$(jq -r '.assets[] | select(.name | test("Windows")) | .browser_download_url' <<<"${response}" | head -n 1)"
win_sha="$(jq -r '.assets[] | select(.name | test("Windows")) | (.digest // "")' <<<"${response}" | head -n 1 | sed 's/^sha256://')"
win_size="$(jq -r '.assets[] | select(.name | test("Windows")) | .size' <<<"${response}" | head -n 1)"

android_url="$(jq -r '.assets[] | select(.name | test("Android")) | .browser_download_url' <<<"${response}" | head -n 1)"
android_sha="$(jq -r '.assets[] | select(.name | test("Android")) | (.digest // "")' <<<"${response}" | head -n 1 | sed 's/^sha256://')"
android_size="$(jq -r '.assets[] | select(.name | test("Android")) | .size' <<<"${response}" | head -n 1)"

linux_url="$(jq -r '.assets[] | select(.name | test("Linux")) | .browser_download_url' <<<"${response}" | head -n 1)"
linux_sha="$(jq -r '.assets[] | select(.name | test("Linux")) | (.digest // "")' <<<"${response}" | head -n 1 | sed 's/^sha256://')"
linux_size="$(jq -r '.assets[] | select(.name | test("Linux")) | .size' <<<"${response}" | head -n 1)"

if [[ -z "${win_url}" || -z "${android_url}" || -z "${linux_url}" ]]; then
  echo "One or more required assets were not found in latest release." >&2
  exit 1
fi

tmp_file="$(mktemp)"

jq \
  --arg version "${tag}" \
  --argjson build_number "${build_number}" \
  --arg release_date "${published_at}" \
  --arg win_url "${win_url}" \
  --arg win_sha "${win_sha}" \
  --argjson win_size "${win_size}" \
  --arg android_url "${android_url}" \
  --arg android_sha "${android_sha}" \
  --argjson android_size "${android_size}" \
  --arg linux_url "${linux_url}" \
  --arg linux_sha "${linux_sha}" \
  --argjson linux_size "${linux_size}" \
  --arg notes_url "https://github.com/${REPO}/releases/tag/${tag}" \
  '
  .version = $version |
  .build_number = $build_number |
  .release_date = $release_date |
  .platforms.windows.installer_url = $win_url |
  .platforms.windows.installer_sha256 = $win_sha |
  .platforms.windows.installer_size = $win_size |
  .platforms.android.installer_url = $android_url |
  .platforms.android.installer_sha256 = $android_sha |
  .platforms.android.installer_size = $android_size |
  .platforms.linux.portable_url = $linux_url |
  .platforms.linux.portable_sha256 = $linux_sha |
  .platforms.linux.portable_size = $linux_size |
  .release_notes_url = $notes_url
  ' latest.json > "${tmp_file}"

mv "${tmp_file}" latest.json

echo "Updated latest.json to ${tag}"
