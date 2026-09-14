# learn/ — 个人学习记录容器

> 本目录是**个人学习记录**（非课程官方内容）：按课程章节组织的学习笔记、
> 运行证据与公共设施。上游文件（课程站源码）保持原样零修改，个人产物只进本目录与 `workspace/`。

## 授权与声明

- 上游：[datawhalechina/deepagents-in-action](https://github.com/datawhalechina/deepagents-in-action)（课程文字 CC BY-NC-SA 4.0，站点代码 MIT）。
- 上游文件保持原样；本 fork 对上游已有文件**零修改**（判据：`git diff origin/main --name-status` 为空）。
- `learn/**`、`workspace/**` 为本人新增内容；密钥只存 `.env`（不入库），任何脚本仅从环境变量读 key。

## 目录导航

| 位置 | 内容 |
|---|---|
| `pre/` | 准备篇（Task 0）：`notes/{guides,research}/` + `evidence/` |
| `chN/`（开章时按 `pre/` 结构创建） | 第 N 章学习记录 |
| `infra/` | 公共设施（`agentseek.ps1` 沙箱绕过封装、`render_evidence.ps1` 证据截图渲染） |
| `HANDOFF.md` | 会话交接文档（新会话 AI 协作者的最小完备上下文，随状态更新） |

## task ↔ 章节映射表（课程节奏）

> ⚠️ 截止时间以组队学习任务卡为准（Task 0 已按任务卡填入）；如有出入以课程官方任务卡为准。

| Task | 主题 | 对应章节 | 截止 | 状态 | 产物位置 |
|---|---|---|---|---|---|
| Task 0 | 环境准备与模板跑通 | pre01 + pre02（ch01/ch02 是否含入以任务卡为准） | 09-15 03:00 | 🔄 | `pre/` |
| Task 1+ | 待任务卡发布后补全 | 待填 | 待填 | ⏳ | 待建 |

## 约定

1. **笔记双轨**：`notes/guides/` = 操作手册轨（怎么做的步骤）；`notes/research/` = 证据核对轨（结论必须带 URL 或 文件:行号）。
2. **证据**：`evidence/` 存 txt（命令输出原文）与 PNG（由 `infra/render_evidence.ps1` 渲染的终端风格截图）；png 是否入库由本人决定。
3. **密钥**：任何脚本只从环境变量读 key；输出不含 key 明文。
