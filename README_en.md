**Notice: Yaru is closed-source software. This repository is only for releases, update metadata, issue tracking, and user-facing documentation.**

# Yaru

Yaru (from Japanese "yaru", meaning "to do") is an all-in-one learning workbench designed around a complete loop: **Input -> Consolidation -> Output -> Feedback**.

## Repository Scope

This repository is the public release surface for Yaru. It is mainly used for:

1. **Releases**: downloadable installers and packages for each platform
2. **Update metadata**: `latest.json` consumed by update flows and release tooling
3. **Issues**: bug reports, feature requests, and release feedback
4. **Docs**: user-facing documentation under `docs/`

In the main Yaru monorepo, this repository is also used as the `Monorepo/distribution/release` submodule.

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
- After the Release assets and remote `latest.json` are verified, the publish workflow performs a GET request to <https://yaru.asaka.moe/download/> so the public download page is visited and warmed as part of the successful release path.

This repository keeps `auto-update-latest-json` as a recovery or resync utility. It can regenerate `latest.json` from the latest published GitHub Release, but it is not the primary signal that a new version has finished publishing.
