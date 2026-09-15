# HANDOFF — 会话交接文档

> 用途：新会话 AI 协作者的最小完备上下文。每次重要节点（任务完成/状态变化）由当值会话更新本文件并随学习提交入库。

## 一句话身份

本仓库 = deepagents-in-action 课程的**个人学习 fork**（rg8diaoa/deepagents-in-action，上游 datawhalechina/deepagents-in-action）；架构 = **主仓保真（上游文件零修改）+ `learn/` 容器 + `workspace/`（agentseek 模板项目，已建并入库）**。

## 当前任务（2026-09-15 午后交接）

**Task 0 ✅ 全部落幕**（三提交已 push：fc0cc9a 建仓 / 3ba75e4 证据归档 / d4433c4 workspace 入库）。下一步：

1. **Step 11 收尾**：精校学习笔记 [pre/notes/guides/Task0学习笔记.md](pre/notes/guides/Task0学习笔记.md)（AI 起草，🖊️ 标记段替换为自身体会；事实素材：[Task0坑位全盘查.md](pre/notes/research/Task0坑位全盘查.md)）
2. **课程 Task 2（截止 09-18 03:00）**：读 ch01（Agent Harness）与 ch02（快速上手）；在 my_deepagent 改提示词/自定义工具触发第一次真实对话（本模板无聊天前端，交互方式看 ch02）；验收/优秀标准见 ch01、ch02 目录 stub

| 事项 | 状态 | 说明 |
|---|---|---|
| Task 0 全链路 | ✅ | clone→环境→AgentSeek→模板→doctor 全绿→网关 health 200 双确认→npx 双技能→workspace 入库（.env/.venv 已排除） |
| 学习心得（Step 11） | ⏳ | 本人撰写；事实素材已备于 notes/research/ |
| Task 1（待任务卡） | ⏳ | 截止与范围以任务卡为准，发布后更新 learn/README.md 映射表 |

## 必读（按序）

1. [AGENTS.md](../AGENTS.md) — 人机协作宪法（分工/密钥/保真/环境坑）
2. [learn/README.md](README.md) — 目录导航 + task 映射表
3. 课程准备篇：pre01-agentseek-create / pre02-agentseek-skills
4. Task 0 坑位全盘查：[pre/notes/research/Task0坑位全盘查.md](pre/notes/research/Task0坑位全盘查.md)（15 条实测坑与处置）

## 铁律（违者停手）

1. **主仓保真**：上游文件零修改（判据 `git diff origin/main --name-status` 为空）
2. **密钥**：只存 `.env`（永不入库）；输出/日志不得含 key 明文
3. **git**：`commit` 仅在本人明确说"提交"时执行；push 需单独确认
4. **笔记**：学习笔记/心得由本人撰写观点，AI 只做格式建议
5. **沙箱内跑 agentseek**：用 `learn/infra/agentseek.ps1`（exe 坑）；本人自己的终端可直接用 `agentseek`

## 状态快照

- 课程 Task 1（环境准备）✅ 完结 = 本仓内部 Task 0（fc0cc9a / 3ba75e4 / d4433c4 已 push，笔记已精校）｜ 课程 Task 2 ⏳ 09-18 03:00 ｜ 全课表见 learn/README.md 映射表（转录自课程表.xls，原件不入库）
- 证据分层（定义见 AGENTS.md §6）：`evidence/` 26 个 = txt 正典 17（含 8 份截图转录）+ AI 渲染 png 9；本人截图 13 张为过程影像，统一 `notes/assets/`

## 更新约定

节点完成/状态变化时更新"当前任务"与"状态快照"，随学习提交入库。
