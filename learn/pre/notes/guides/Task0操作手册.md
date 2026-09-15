# Task 0 操作手册（准备篇）

> 用途：本人人工执行剩余步骤时的对照手册。AI 代办部分已标注结果与证据索引。
> 截止：**2026-09-15 03:00**（任务卡）。
> 术语：「本人终端」= Agent 之外的 PowerShell（已验证 `agentseek` 可直接用）；
> 「沙箱内」= Agent 会话里（exe 有 0xC0000135 坑，统一用 `learn\infra\agentseek.ps1` 封装）。

## 状态总览

| 步骤 | 内容 | 状态   | 证据 |
|---|---|-----|---|
| Step 0 | fork + clone | ✅ 2026-09-15   | `evidence/20260915_step0_clone.png` |
| Step 1 | learn/ 骨架 | ✅ 2026-09-15   | `evidence/20260915_step1-2_learn_skeleton.png` |
| Step 2 | AGENTS.md 协作规则 | ✅ 已本人审定生效   | 同上 |
| Step 3 | 环境探测 | ✅ 全达标   | `evidence/20260915_step3_env_check.png` |
| Step 4 | AgentSeek 安装 | ✅（exe 坑仅限沙箱，本人终端已验证正常）   | `evidence/20260915_step4_agentseek_install.png` + `20260915_step4b_agentseek_own_terminal.png` |
| Step 5-11 | 模板创建 → 跑通 → 技能 → 归档 | ✅ 5-10 全部完成（doctor 全绿 + health 200 双确认 + npx 双技能落装）；11 心得待本人撰写 | `evidence/20260915_step9_gateway_health.png` 等 + 本人截图 |

## 环境基线（Step 3 实测）

git 2.53.0.2 ｜ Python 3.12.10 ｜ Node v24.14.1 ｜ npm 11.11.0 ｜ uv 0.12.13

坑位：`py` 启动器损坏（指向不存在的路径）→ 一律用 `python`；
`agentseek.exe` 启动报 0xC0000135 → 沙箱内用 `.\learn\infra\agentseek.ps1`，
本人终端若也复现，同样可用 `& "$env:APPDATA\uv\tools\agentseek\Scripts\python.exe" -m agentseek <args>`。

## Step 5：创建模板项目（本人动手）

```powershell
cd E:\Documents\deepagenrs-in-action
mkdir workspace; cd workspace
# 本人终端：
agentseek create deepagents/default --checkout main --no-input
# 沙箱内改用：
# ..\learn\infra\agentseek.ps1 create deepagents/default --checkout main --no-input
```

**验证**：`workspace` 下生成项目目录；**通读生成项目里的 README.md（必读）**，后续 .env 字段以它为准。
Task 0 / ch01 / ch02 均用 `deepagents/default`；后面章节才换 `research`、`content-builder` 等模板。

## Step 6：配置 .env（密钥只进 .env，永不入库）

```powershell
cd <生成的项目目录>
Copy-Item .env.example .env
```

本模板（deepagents/default）的变量是 `BUB_*` 系（接受 AGENTSEEK_*/OPENAI_* 别名，见 `.env.example` 与 `.agentseek/lifecycle.toml`）：

- `BUB_MODEL=openai:<模型名>`（硅基流动就去[模型广场](https://cloud.siliconflow.cn/models)选一个支持工具调用的，如 Qwen 系列）
- `BUB_API_KEY=<你的硅基流动 key>`；`BUB_API_BASE=https://api.siliconflow.cn/v1`
- 模板已注册 ProviderProfile（`use_responses_api=False`）强制走 Chat Completions → 正好兼容 OpenAI 兼容端点（README「DeepAgents profiles」一节）
- 想要 Trace：另加 `LANGSMITH_TRACING=true`、`LANGSMITH_API_KEY=<key>`（LangChain 读标准变量，模板没列也能用）
- ⚠️ 课程 README 提到的 `MODEL_NAME` 本模板不存在 → drift，以生成项目的 `.env.example` 为准

**验证**：`git status` —— `.env` 不得出现在待提交列表。

## Step 7：安装依赖

**执行目录：项目目录**（`E:\Documents\deepagenrs-in-action\workspace\my_deepagent`；判据：这层有 `pyproject.toml` 和 `.agentseek/`）

```powershell
uv sync
```

⚠️ **`npm install --prefix frontend` 跳过**：default 模板无前端（README 原话 "does not include a frontend"，实测 ENOENT 佐证，见 evidence/20260915_step7_npm_enoent）。只有带 frontend 的模板（如 research）才需要 npm 步骤。

## Step 8：体检与启动

**执行目录：项目目录**（同 Step 7；`agentseek` 的 task/doctor/dev 都读项目配置，在仓库根跑会找不到项目）

```powershell
agentseek info
agentseek task --list
agentseek task sync      # 等价于 uv sync（已做过可跳）
agentseek doctor
agentseek dev            # 沙箱内: ..\learn\infra\agentseek.ps1 dev
```

- 本模板启动的是 **Bub AG-UI 网关**（`uv run bub gateway --enable-channel ag-ui`），端口 **18088**，没有 langgraph.json
- doctor 有红灯先修再继续；dev 起来后浏览器开 `http://127.0.0.1:18088/agent/health` 应返回健康状态

## Step 9：验证跑通（打卡核心证据，截图自己截）

**执行目录：无终端命令**（浏览器操作）；截图属过程影像，统一存 `learn/pre/notes/assets/`，命名 `20260915_stepN_slug.png`（产物文本由转录进 evidence/）。

1. `agentseek dev` 运行时，浏览器开 `http://127.0.0.1:18088/agent/health` 确认网关健康（本模板无聊天前端，真实对话交互在 ch02 展开）；
2. （可选，强烈推荐）.env 配好 LangSmith 后触发一次调用，到 LangSmith 网页看 Trace（调用链路 / 节点输入输出 / Token 用量）；
3. 截图存 `learn/pre/notes/assets/`（建议命名 `20260915_step9_gateway_health.png`、`20260915_step9_langsmith.png`；产物文本转录进 evidence/）。

## Step 10：安装开发技能

**执行目录：项目目录**（与 `.env` 同层；技能装到项目的 `.agents/skills/` 并为各编码助手建符号链接）

⚠️ pre02 教的 `agentseek skills ...` 在 0.1.4 已被移除（实测报 No such command；`--help` 显示 0.1.4 仅剩 version/dev/info/doctor/task/create）。用课程 README 的上游写法：

```powershell
npx skills add ob-labs/agentseek --skill langchain-dev-guide
npx skills add ob-labs/agentseek --skill langsmith-trace
```

（首次运行 npx 会提示安装 skills 包，按 y 确认；装完检查项目下 `.agents/skills/` 目录。编码助手未自动触发技能时，提问里点名技能名。）

## Step 11：收尾归档

1. 踩坑与结论写入 `notes/`（guides=操作步骤，research=带 URL/文件:行号的结论）；**心得观点本人撰写**；
2. 更新 `learn/HANDOFF.md` 状态快照（Task 0 → ✅）；
3. 对 AI 明确说「提交」才执行 commit；push 需单独确认。

## 已知 drift 与坑位速查

| 现象 | 处理 |
|---|---|
| pre01 正文写 `uv tool install agentseek-cli`、版本 0.0.3 | 以课程 README 为准：`agentseek`（实测装到 0.1.4） |
| pre01 示例用 `deepagents/research` 模板、手跑 `uv run langgraph dev` | Task 0 用 `deepagents/default`；启动以 README 的 `agentseek dev` 为准 |
| `agentseek.exe` 启动 0xC0000135（DLL 未找到） | 沙箱内用 `learn/infra/agentseek.ps1`；本人终端复现则用上文的 `python -m agentseek` |
| `py` 报 Unable to create process | 用 `python`（系统 Python 3.12.10 正常） |
| `npm install --prefix frontend` 对 default 模板报 ENOENT | 模板无前端，跳过 npm；仅 research 等模板需要 |
| 课程 README 提 `MODEL_NAME`、pre01 示例含前端 | 本模板实际用 `BUB_MODEL`（别名 AGENTSEEK_MODEL）、无前端、dev=bub 网关(18088)——以生成项目的 README + `.env.example` + `.agentseek/lifecycle.toml` 为准 |
| pre02 的 `agentseek skills` 报 No such command | 0.1.4 已移除该命令（`--help` 实测仅 version/dev/info/doctor/task/create）；改用课程 README 的 `npx skills add ob-labs/agentseek --skill <名称>` |
