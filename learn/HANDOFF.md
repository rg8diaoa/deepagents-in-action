# HANDOFF — 会话交接文档

> 用途：新会话 AI 协作者的最小完备上下文。每次重要节点（任务完成/状态变化）由当值会话更新本文件并随学习提交入库。

## 一句话身份

本仓库 = deepagents-in-action 课程的**个人学习 fork**（rg8diaoa/deepagents-in-action，上游 datawhalechina/deepagents-in-action）；架构 = **主仓保真（上游文件零修改）+ `learn/` 容器 + `workspace/`（agentseek 模板项目，待建）**。

## 当前任务（2026-09-15 交接）

**Task 0：准备篇（截止 2026-09-15 03:00）** —— AgentSeek CLI 安装 ✅（exe 坑已绕过）、`deepagents/default` 模板创建与跑通 ⏳、开发技能安装 ⏳。

| 事项 | 状态 | 说明 |
|---|---|---|
| fork + clone | ✅ | origin → rg8diaoa/deepagents-in-action |
| learn/ 骨架 + AGENTS.md | ✅ | AGENTS.md 已本人审定生效；剩余步骤对照 learn/pre/notes/guides/Task0操作手册.md |
| 环境探测 | ✅ | 见 AGENTS.md §3（python 3.12.10 / node v24.14.1 / uv 0.12.13） |
| AgentSeek 安装 | ⚠️ | 0.1.4 已装；exe 在沙箱内启动失败（0xC0000135），用 `learn/infra/agentseek.ps1` 绕过；本人终端待验证 |
| Step 5-11（模板创建→跑通→技能） | ⏳ | **本人动手**：`agentseek create deepagents/default --checkout main --no-input` |

## 必读（按序）

1. [AGENTS.md](../AGENTS.md) — 人机协作宪法（分工/密钥/保真/环境坑）
2. [learn/README.md](README.md) — 目录导航 + task 映射表
3. 课程准备篇：pre01-agentseek-create / pre02-agentseek-skills

## 铁律（违者停手）

1. **主仓保真**：上游文件零修改（判据 `git diff origin/main --name-status` 为空）
2. **密钥**：只存 `.env`（永不入库）；输出/日志不得含 key 明文
3. **git**：`commit` 仅在本人明确说"提交"时执行；push 需单独确认
4. **笔记**：学习笔记/心得由本人撰写观点，AI 只做格式建议
5. **沙箱内跑 agentseek**：用 `learn/infra/agentseek.ps1`（exe 坑）；本人自己的终端可直接用 `agentseek`

## 状态快照

- Task 0 🔄（截止 2026-09-15 03:00）｜ 环境就绪 ｜ AgentSeek 0.1.4 已装（exe 坑已绕过）｜ 模板项目未创建
- 证据：`learn/pre/evidence/20260915_*.txt/png`（clone / env / agentseek / 骨架四组，成败均有）

## 更新约定

节点完成/状态变化时更新"当前任务"与"状态快照"，随学习提交入库。
