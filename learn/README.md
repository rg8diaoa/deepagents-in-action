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
| `pre/` | 准备篇（Task 0）：`notes/{guides,research}/` + `notes/assets/`（本人截图）+ `evidence/`（产物证据） |
| `chN/`（开章时按 `pre/` 结构创建） | 第 N 章学习记录 |
| `infra/` | 公共设施（`agentseek.ps1` 沙箱绕过封装、`render_evidence.ps1` 证据截图渲染） |
| `HANDOFF.md` | 会话交接文档（新会话 AI 协作者的最小完备上下文，随状态更新） |

## task ↔ 章节映射表（课程节奏）

> 来源：`课程表.xls`（2026-09-14 开营，共 22 天，截止均为凌晨 03:00；原件不入库）。课程编号 Task 1 = 环境准备，与本仓早期文档的「Task 0」同指。

| 课程任务 | 主题 | 对应章节 | 截止 | 状态 | 产物位置 |
|---|---|---|---|---|---|
| Task 1 | 环境准备（Python / 模型 API / Git / LangSmith 自检） | pre01 + pre02 | 09-15 03:00 | ✅ | `pre/` + `workspace/` |
| Task 2 | 第 1 章 Framework/Harness + 第 2 章快速上手 | ch01 + ch02 | 09-18 03:00 | ⏳ | `ch01/`、`ch02/` |
| Task 3 | 第 3 章虚拟文件系统与存储后端 | ch03 | 09-21 03:00 | ⏳ | `ch03/` |
| Task 4 | 第 4 章任务规划与分解 | ch04 | 09-24 03:00 | ⏳ | `ch04/` |
| Task 5 | 第 5 章子 Agent 与上下文隔离 | ch05 | 09-26 03:00 | ⏳ | `ch05/` |
| Task 6 | 第 6 章异步子 Agent + 第 7 章 Skills | ch06 + ch07 | 09-30 03:00 | ⏳ | `ch06/`、`ch07/` |
| Task 7 | 第 8 章长期记忆 + 第 9 章 Human-in-the-Loop | ch08 + ch09 | 10-04 03:00 | ⏳ | `ch08/`、`ch09/` |
| Task 8 | 综合项目开发、Demo 结营 | 综合运用 ≥3 项课程能力 | 10-06 03:00 | ⏳ | `final/` |

## 约定

1. **笔记双轨**：`notes/guides/` = 操作手册轨（怎么做的步骤）；`notes/research/` = 证据核对轨（结论必须带 URL 或 文件:行号）。
2. **证据**：evidence/ 只收**实验本身的产物记录**——txt 为正典（可 grep/diff），AI 渲染 png 为忠实副本（`infra/render_evidence.ps1` 由 txt 重生成）；本人截图属过程影像，存 `notes/assets/` 供笔记嵌图，不入 evidence/。任何 .gitignore 不得忽略 evidence/ 已入库文件。
3. **密钥**：任何脚本只从环境变量读 key；输出不含 key 明文。
