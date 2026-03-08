**⚠️ 注意：Yaru 为闭源软件。本仓库仅用于版本发布、更新元数据、问题追踪与面向用户的文档。**

# Yaru（浅颂）

Yaru（やる，to do）是一款面向学习者的 All-in-one 学习工作台，围绕 **输入 → 巩固 → 输出 → 反馈** 的完整闭环设计，帮助你减少工具切换，把注意力集中在学习本身。

## 仓库用途

本仓库是 Yaru 的公开发行面，主要用于：

1. **版本发布（Releases）**：提供各平台安装包与发布资产
2. **更新元数据**：维护供更新流程与发布工具使用的 `latest.json`
3. **问题追踪（Issues）**：提交 Bug、功能建议与版本反馈
4. **用户文档（Docs）**：提供 `docs/` 下的面向用户说明

在主 Yaru 单体仓库中，本仓库也作为 `Monorepo/distribution/release` 子模块使用。

## 下载入口

- GitHub Releases：<https://github.com/asakatea/Yaru-release/releases>
- 产品下载页：<https://yaru.asaka.moe/download>

如果你想直接获取已发布的原始安装包，请使用 GitHub Releases；如果你想从 Yaru 官网进入统一下载入口，请使用产品下载页。

## 更新机制说明

Yaru 的版本更新元数据以 `latest.json` 为中心：

- `latest.json` 记录当前版本号、发布日期、最低支持版本，以及各平台下载链接与校验信息。
- 主 Yaru 仓库中的发布工作流会构建多平台产物、上传到本仓库的 GitHub Release、合并各平台信息生成 `latest.json`，然后从 Release 下载地址反向校验该清单。
- 只有在 Release 资产上传成功且远端 `latest.json` 校验通过后，主发布流程才会再对 <https://yaru.asaka.moe/download> 发起一次 GET 请求，用于把“下载页访问 / 预热”绑定到真正的发布成功状态上。

需要注意：这次访问本身**不会**自动改写落地页上的下载按钮数据源。如果官网仍显示占位链接或旧的发行说明，那通常是站点数据实现层的问题，而不是发布资产没有上传成功。

## 维护者视角的发布流程概览

1. 在主 Yaru 单体仓库中构建各平台发布产物。
2. 在 `asakatea/Yaru-release` 中创建或更新对应 GitHub Release。
3. 上传安装包 / 压缩包，并合并生成 `latest.json`。
4. 从 Release 下载地址校验远端 `latest.json`。
5. 校验成功后，再以 GET 请求访问 <https://yaru.asaka.moe/download>。
6. 如有需要，可再使用本仓库的 `auto-update-latest-json` 工作流，从最新 GitHub Release 重新同步 `latest.json`。

## 关键文件

- `latest.json`：本仓库对外提供的更新清单
- `.github/workflows/auto-update-latest-json.yml`：本仓库内用于定时 / 手动 / 发布后重建 `latest.json` 的工作流
- `scripts/update-latest-json.sh`：上面工作流调用的脚本，用于读取 GitHub Releases API 并改写 `latest.json`
- `docs/`：随发行仓库一同维护的用户文档目录

## 快速入口

- 下载发布版：<https://github.com/asakatea/Yaru-release/releases>
- 反馈问题：<https://github.com/asakatea/Yaru-release/issues>
- 产品下载页：<https://yaru.asaka.moe/download>
- 中文文档（简体）：[`docs/zh/`](./docs/zh/)
- 中文文档（繁体）：[`docs/zh_Hant/`](./docs/zh_Hant/)
- English Docs：[`docs/en/`](./docs/en/)

## 同步预期与排查

- 如果 GitHub Release 已经发布，但落地页短时间内看起来还没变化，先检查 Release 资产和 `latest.json`，不要立即判断发布失败。
- 如果 `latest.json` 缺少平台字段或下载地址不正确，优先检查主发布工作流日志，以及发布时生成的 Release 资产。
- 如果落地页本身仍然显示占位按钮或静态版本信息，需要单独检查网站实现；仅仅发布新版本并不会自动改写这些站点内容。

## 为什么做 Yaru

很多学习工具都很优秀，但通常只覆盖一个环节：

- 输入工具很多，但输入后难以顺畅进入巩固与输出
- 闪卡工具效果好，但制卡成本高、上下文容易丢失
- 笔记与知识库工具强大，但容易陷入“搭系统”而不是“学内容”
- 多端体验割裂，移动端学习与回顾成本高

Yaru 的目标是把这些环节连接起来，形成可持续的学习 workflow。

## 核心模块

- **📖 学习模块**：路线图式课程学习（类似 Brilliant / Math Academy）
- **📚 书库模块**：支持 PDF / EPUB / MOBI / AZW3 / Markdown / HTML
- **🧠 记忆模块**：间隔重复 + 主动召回
- **✍️ 创作模块**：积木式编辑器（Block Editor）
- **🧩 扩展模块**：计划支持浏览器扩展、RSS、视频摘要导入
- **📝 笔记 / 题库 / 社区**：持续建设中

## 主要特点

- Material You 设计，界面简洁无广告
- 跨平台：Android / Windows / Linux / macOS / Web
- 学习与记忆一体化，减少重复搬运与导入导出
- 强调上下文保留，降低“知识碎片化”

## 软件截图

### 桌面端

| 首页 | 学习 |
|---|---|
| ![Desktop Homepage](pics/desktop/en/homepage.png) | ![Desktop Study](pics/desktop/en/study.png) |

| 书库 | 记忆 |
|---|---|
| ![Desktop Library](pics/desktop/en/library.png) | ![Desktop Memory](pics/desktop/en/memoryhub.png) |

| 创作 | 我的 |
|---|---|
| ![Desktop Create](pics/desktop/en/cr.png) | ![Desktop Mine](pics/desktop/en/mine.png) |

### 移动端

| 首页 | 学习 |
|---|---|
| ![Mobile Homepage](pics/mobile/en/mainpage.png) | ![Mobile Study](pics/mobile/en/study_page.png) |

| 书库 | 记忆 |
|---|---|
| ![Mobile Library](pics/mobile/en/library.png) | ![Mobile Memory](pics/mobile/en/memory_hub.png) |

| 笔记块编辑器 | 我的 |
|---|---|
| ![Mobile Note Blocks Editor](pics/mobile/en/note_blocks_editor.png) | ![Mobile Mine](pics/mobile/en/mine.png) |

## 语言版本

- 中文：[`README_zh.md`](./README_zh.md)
- English：[`README_en.md`](./README_en.md)
