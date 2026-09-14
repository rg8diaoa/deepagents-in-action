# AGENTS.md — 人机协作规则（学习期）

> 状态：**已生效**（2026-09-15 起草，经本人审定）。
> 对本仓库工作的任何 AI agent 生效（TRAE / Codex / Claude Code 等）。
> 核心理念：学习 Deep Agents 要有自己的思想，课程实验本身必须本人完成；
> 但使用 agent 本身也是一种能力，不涉及课程实验本身的准备工作可委托 AI 代办。

## 1. 分工边界

| 类别 | 谁做 | 例子 |
|---|---|---|
| 课程实验代码与配置（`workspace/**` 内模板项目的修改） | **本人** | 改 `src/agent.py`、自定义工具、改模板配置、跑 `agentseek dev` |
| 学习笔记 / 心得（`learn/**/notes/**`） | **本人撰写观点**；AI 只做格式建议，不代写观点 | Task 0 打卡学习心得 |
| 环境与脚手架（安装、建仓骨架、环境探测） | **AI 可代办** | uv / AgentSeek 安装、`learn/` 骨架创建 |
| 资料核对与文档（`AGENTS.md`、`learn/HANDOFF.md` 等元文档） | AI 起草、本人审定 | 每条结论必须带 文件:行号 或官方 URL |
| git 提交 | 仅在本人明确说"提交"时执行 | push 需单独确认 |

## 2. AI 行为准则

1. **结论可验证**：涉及代码 / 环境的结论给出 文件:行号 或官方文档 URL；文档与实际冲突时，以本地代码 + 实测为最终裁判。
2. **不代替思考**：机制类问题解释原理 + 给验证路径，不直接给"做完的作业"。
3. **密钥安全**：key 只存项目根 `.env`（被 .gitignore 忽略）；任何回复、日志、提交中不得出现密钥明文。
4. **主仓保真**：上游文件（课程站源码）零修改，判据：`git diff origin/main --name-status` 输出为空；个人产物只进 `learn/` 与 `workspace/`。
5. **产物归位**：学习/研究类 md 一律写入 `learn/preN|chN/notes/{guides,research}/`（guides=操作手册，research=证据核对），不在仓库根或其它目录散落。
6. **文档 drift 登记**：课程文档已发现的不一致，优先以课程 README 为准：
   - README 写 `uv tool install --upgrade agentseek`（PyPI 包名 `agentseek`，实测 0.1.4 可装）；pre01 正文写 `uv tool install agentseek-cli`、版本 0.0.3 —— 以 README 为准（2026-09-15 实测）。

## 3. 环境备忘（2026-09-15 实测，供后续 agent 免踩坑）

- Windows + TRAE 沙箱环境。git 2.53.0.2 ｜ Python 3.12.10 ｜ Node v24.14.1 ｜ npm 11.11.0 ｜ uv 0.12.13。
- `py` 启动器损坏（指向不存在的 `C:\Users\Administrator\world-simulator\Python\pythoncore-3.14-64\python.exe`），统一用 `python` 命令即可。
- AgentSeek CLI：`uv tool install --upgrade agentseek` 安装成功（`agentseek==0.1.4`，93 个依赖包）。
  - **坑**：`agentseek.exe`（uv trampoline 启动器）本机启动即报 `0xC0000135`（DLL 未找到），复制到任意目录（含 %TEMP%）均复现；对照组：复制 `uv.exe` 为新文件可正常运行 → 排除"沙箱拦截新 exe"，是 trampoline 启动器本身的问题。
  - **可用绕过**（已验证 exit 0）：`& "$env:APPDATA\uv\tools\agentseek\Scripts\python.exe" -m agentseek <args>`，或用本仓库封装 [learn/infra/agentseek.ps1](learn/infra/agentseek.ps1)。
  - 已验证（2026-09-15）：本人终端（沙箱外）`agentseek version` 正常（v0.1.4）→ 该坑仅存在于 TRAE 沙箱内，本机环境与 exe 本身无恙。
- uv 写工作区外缓存正常（2026-09-15 安装全程无 os error 5），环境结论一律以本仓实测为准。

## 4. 规则指针

- 目录导航 + task↔章节映射表：[learn/README.md](learn/README.md)
- 会话交接文档（新会话 AI 先读）：[learn/HANDOFF.md](learn/HANDOFF.md)
- 课程入口：https://github.com/datawhalechina/deepagents-in-action（准备篇 pre01 / pre02）

## 5. 记忆机制（当前方案）

- 本文件 = 跨工具协作宪法。
- 实验进度 / 任务状态**不写进规则文件**——以 git log + `learn/HANDOFF.md` + 各章笔记为准（文档即记忆）。
