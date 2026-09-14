# Task 0 操作手册（准备篇）

> 用途：本人人工执行剩余步骤时的对照手册。AI 代办部分已标注结果与证据索引。
> 截止：**2026-09-15 03:00**（任务卡）。
> 术语：「本人终端」= TRAE 之外的 PowerShell（`agentseek` 可直接用，待你验证）；
> 「沙箱内」= TRAE 会话里（exe 有 0xC0000135 坑，统一用 `learn\infra\agentseek.ps1` 封装）。

## 状态总览

| 步骤 | 内容 | 状态 | 证据 |
|---|---|---|---|
| Step 0 | fork + clone | ✅ 2026-09-15 | `evidence/20260915_step0_clone.png` |
| Step 1 | learn/ 骨架 | ✅ 2026-09-15 | `evidence/20260915_step12_learn_skeleton.png` |
| Step 2 | AGENTS.md 协作规则 | ✅ 已本人审定生效 | 同上 |
| Step 3 | 环境探测 | ✅ 全达标 | `evidence/20260915_step3_env_check.png` |
| Step 4 | AgentSeek 安装 | ✅（exe 坑已定位并绕过） | `evidence/20260915_step4_agentseek_install.png` |
| Step 5-11 | 模板创建 → 跑通 → 技能 → 归档 | ⏳ **本人执行** | 完成后自行补证据 |

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

按项目 README 填：

- 模型供应商：课程推荐硅基流动（新用户注册有代金券），注意 `MODEL_NAME` 环境变量
- LangSmith（smith.langchain.com，强烈推荐）：后续 Trace 调试全靠它
- Tavily：`default` 模板如无联网搜索需求可暂不填（`research` 模板才必须）

**验证**：`git status` —— `.env` 不得出现在待提交列表。

## Step 7：安装依赖

```powershell
uv sync
npm install --prefix frontend
```

## Step 8：体检与启动

```powershell
agentseek task --list
agentseek doctor
agentseek dev      # 沙箱内: ..\learn\infra\agentseek.ps1 dev
```

doctor 有红灯先修再继续；dev 启动后记下后端/前端端口。

## Step 9：验证跑通（打卡核心证据，截图自己截）

1. 浏览器打开前端地址，发一条消息，确认 Agent 正常回复；
2. LangSmith 网页确认本次运行 Trace（调用链路 / 节点输入输出 / Token 用量）；
3. 截图存 `learn/pre/evidence/`（建议命名 `20260915_step9_frontend.png`、`20260915_step9_langsmith.png`）。

## Step 10：安装开发技能

```powershell
agentseek skills list
agentseek skills add --skill langchain-dev-guide -g
agentseek skills add --skill langsmith-trace -g
```

（等价写法：`npx skills add ob-labs/agentseek --skill <名称>`；编码助手未自动触发技能时，提问里点名技能名。）

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
