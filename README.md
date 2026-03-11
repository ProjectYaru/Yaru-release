# Yaru Release Repository

Yaru is closed-source software. This repository is the public release surface for Yaru installers, update metadata, issue tracking, and user-facing documentation. In the main Yaru monorepo it is also used as the `Monorepo/distribution/release` submodule.

## Language Entry

- English: [`README_en.md`](./README_en.md)
- Simplified Chinese: [`README_zh.md`](./README_zh.md)

## What This Repository Contains

- **GitHub Releases** for downloadable installers and packages
- **`latest.json`** for update metadata used by release and update flows
- **Issues** for bug reports, feature requests, and release feedback
- **Docs** for user-facing release and update documentation

## Key Links

- GitHub Releases: <https://github.com/ProjectYaru/Yaru-release/releases>
- Product download page: <https://yaru.asaka.moe/download>
- Issues: <https://github.com/ProjectYaru/Yaru-release/issues>
- English docs: [`docs/en/`](./docs/en/)
- Simplified Chinese docs: [`docs/zh/`](./docs/zh/)
- Traditional Chinese docs: [`docs/zh_Hant/`](./docs/zh_Hant/)

## Update Metadata and Publish Flow

Yaru release metadata is centered on `latest.json`:

- `latest.json` records the current version, release date, minimum supported version, and per-platform download/checksum information.
- The main Yaru monorepo publish flow builds platform artifacts, uploads them to the GitHub Release in this repository, merges platform metadata into `latest.json`, and validates that metadata against the uploaded release assets.
- After the release assets and remote `latest.json` are verified, the publish workflow performs a GET request to <https://yaru.asaka.moe/download/> so the public download page is visited and warmed as part of the successful release path.

This repository keeps `auto-update-latest-json` as a recovery or resync utility. It can regenerate `latest.json` from the latest published GitHub Release, but it is not the primary signal that a new version has finished publishing.
