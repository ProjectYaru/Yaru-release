**说明：Yaru 为闭源软件。本仓库仅用于发布安装包、维护更新元数据、收集问题反馈，以及提供面向用户的文档。**

# Yaru

Yaru（取自日语 “yaru”，意为“去做”）是一套围绕 **输入 -> 巩固 -> 输出 -> 反馈** 学习闭环设计的 all-in-one 学习工作台。

## 仓库范围

这个仓库是 Yaru 的公开发布面，主要用于：

1. **Releases**：提供各平台可下载的安装包与发行件
2. **更新元数据**：维护更新流程与发布工具使用的 `latest.json`
3. **Issues**：收集缺陷报告、功能建议与发布反馈
4. **文档**：提供 `docs/` 下的用户文档与发布说明

在主 Yaru Monorepo 中，本仓库也作为 `Monorepo/distribution/release` 子模块使用。

## 关键链接

- GitHub Releases：<https://github.com/ProjectYaru/Yaru-release/releases>
- 产品下载页：<https://yaru.asaka.moe/download>
- 问题反馈：<https://github.com/ProjectYaru/Yaru-release/issues>
- 英文文档：[`docs/en/`](./docs/en/)
- 简体中文文档：[`docs/zh/`](./docs/zh/)
- 繁體中文文档：[`docs/zh_Hant/`](./docs/zh_Hant/)

## 更新元数据与发布流程

Yaru 的发布元数据以 `latest.json` 为中心：

- `latest.json` 记录当前版本、发布日期、最低支持版本，以及各平台下载地址、校验值和体积信息。
- 主 Yaru Monorepo 的发布流程会构建各平台产物，上传到本仓库的 GitHub Release，再把各平台元数据合并进 `latest.json`，并对照已上传的 Release 资产进行校验。
- 当 Release 资产与远端 `latest.json` 都校验通过后，发布流程还会访问 <https://yaru.asaka.moe/download/>，作为公开下载页预热与发布成功路径的一部分。

本仓库保留 `auto-update-latest-json` 作为恢复或重新同步工具。它可以根据最新的 GitHub Release 重建 `latest.json`，但它不是判断新版本已完成发布的主信号。
