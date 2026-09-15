# Task 0 坑位全盘查（学习笔记素材 · 事实层）

> 性质：**事实盘查**（现象 → 根因 → 处置 → 证据），供本人撰写学习笔记引用。
> 规矩：规律提炼与心得观点由本人撰写（AGENTS.md 分工边界）。
> 证据链接：txt 正典与 AI 渲染副本在 `../../evidence/`，本人截图影像在 `../assets/`；GitHub / VS Code / Typora 下可直接点开。
> 分层阅读：叙事层看 [../guides/Task0学习笔记.md](../guides/Task0学习笔记.md) ｜ 命令层看 [../guides/Task0操作手册.md](../guides/Task0操作手册.md) ｜ 本文 = 坑位层。
> 时间：2026-09-15 00:30–02:40（凌晨冲刺 + 午后收尾）｜ 统计：实质坑 12 ｜ 认知项 2 ｜ 环境结论澄清 1

## A. 环境类

### A1 `py` 启动器损坏 🔁绕过（根因遗留）
- 现象：`py --version` → `Unable to create process 'C:\Users\Administrator\world-simulator\Python\pythoncore-3.14-64\python.exe'`
- 根因：py launcher 注册表指向一个已被移除的 Python 3.14 安装目录（world-simulator 残留）
- 处置：一律改用 `python`（系统 Python 3.12.10 正常）
- 证据：[20260915_step3_env_check.png](../../evidence/20260915_step3_env_check.png)

### A2 `agentseek.exe` 在沙箱限制环境内启动即崩（0xC0000135）🔁绕过
- 现象：沙箱内启动报 DLL 未找到（0xC0000135），复制到 %TEMP% 仍复现
- 定位链：`uv tool list` 正常 → 复制 `uv.exe` 为新文件能跑（排除"沙箱拦新 exe"）→ 工具 venv 的 `python.exe` 正常 → 锁定 uv trampoline 启动器 × 沙箱组合
- 反转：**本人终端（沙箱外）`agentseek version` 完全正常** → 坑仅存在于沙箱内
- 处置：沙箱内统一走 `learn/infra/agentseek.ps1`（venv python -m agentseek）
- 证据：[20260915_step4_agentseek_install.png](../../evidence/20260915_step4_agentseek_install.png)（排障全程）｜ [20260915_step4b_agentseek_own_terminal.png](../../evidence/20260915_step4b_agentseek_own_terminal.png)（本人终端复核）｜ [20260915_step4c_agentseek_version.png](../assets/20260915_step4c_agentseek_version.png)（本人实拍 v0.1.4 正常）

### A3 旧环境结论不可跨仓沿用 ✅澄清
- 现象：曾有"uv 写工作区外缓存会 os error 5"的旧结论，本次安装全程无此问题
- 教训：环境类结论绑定具体机器+沙箱+仓库组合，**每次实测重验**，不进新仓的规则文件
- 证据：[20260915_step4_agentseek_install.png](../../evidence/20260915_step4_agentseek_install.png)（安装 93 包全程无 os error 5）

## B. 文档 drift 类（文档滞后于工具演进）

### B1 安装包名：`agentseek-cli` vs `agentseek` ✅解决
- pre01 写 `uv tool install agentseek-cli`（0.0.3 时代）；课程 README 写 `agentseek`
- 实测：`agentseek` 安装成功（0.1.4）→ **以课程 README 为准**
- 证据：[20260915_step4_agentseek_install.png](../../evidence/20260915_step4_agentseek_install.png)（安装输出 `+ agentseek==0.1.4`）｜ [20260915_step4c_agentseek_version.png](../assets/20260915_step4c_agentseek_version.png)（本人终端 AGENTSEEK v0.1.4）

### B2 模型变量名：`MODEL_NAME` vs `BUB_MODEL` ✅解决
- 课程 README 提 `MODEL_NAME`；本模板实际读 `BUB_MODEL/BUB_API_KEY/BUB_API_BASE`（接受 AGENTSEEK_*/OPENAI_* 别名）
- 权威源：生成项目的 `.env.example` + `.agentseek/lifecycle.toml`
- 证据：[20260915_step8_info_tasklist.png](../assets/20260915_step8_info_tasklist.png)（`agentseek info` 逐项列出 BUB_* 变量名）｜ [20260915_step6_env_copy.png](../assets/20260915_step6_env_copy.png)（.env 落盘现场）

### B3 模板无前端 vs pre01 示例有前端 ✅解决
- 现象：`npm install --prefix frontend` → ENOENT（`frontend\package.json` 不存在）
- 根因：`deepagents/default` 是纯后端 AG-UI 网关模板，README 原话 "does not include a frontend"；pre01 示例用的是带前端的 `research` 模板
- 处置：default 模板跳过 npm；验证改走 `/agent/health`
- 证据：[20260915_step7_npm_enoent.png](../../evidence/20260915_step7_npm_enoent.png)

### B4 `agentseek skills` 命令被移除 ✅解决
- 现象：`No such command 'skills'`
- 实测：0.1.4 的 `--help` 仅剩 version/dev/info/doctor/task/create（0.0.3 时代的 run/build/deploy/api/ctx/skills 全没了）
- 处置：改用课程 README 的上游写法 `npx skills add ob-labs/agentseek --skill <名称>`
- 证据：[20260915_step10_skills_command_drift.png](../../evidence/20260915_step10_skills_command_drift.png)

## C. 操作类

### C1 `---prefix` 三横线笔误 ✅纠正（侥幸未爆）
- npm 的参数解析容忍了多余横线（报错路径含 \frontend\ 证明 prefix 仍生效），但标准写法 `--prefix`
- 教训：工具的容错不是正确性依据
- 证据：[20260915_step7_npm_enoent.png](../../evidence/20260915_step7_npm_enoent.png)（首行可见 `---prefix` 原命令）

### C2 `GET / 404`（网页报 Not Found）✅解决
- 现象：浏览器开 `http://127.0.0.1:18088/` 得 `{"detail":"Not Found"}`
- 根因：网关路由全挂在 `/agent` 前缀下（lifecycle.toml 声明），`/` 与 `/agent` 本身就是 404
- 正确地址：`http://127.0.0.1:18088/agent/health` → 200
- 附注：health 端点会回显 PATH 环境变量（本地接口，记录在案）
- 证据：[20260915_step8_dev_up_health200.png](../assets/20260915_step8_dev_up_health200.png)（404 与 200 同框）｜ [20260915_step9_health_browser.png](../assets/20260915_step9_health_browser.png)（本人浏览器 200）｜ [20260915_step9_gateway_health.png](../../evidence/20260915_step9_gateway_health.png)（AI 探测复核）

### C3 doctor 拦截 `BUB_API_KEY` 空值 ✅解决
- 现象：doctor 9 项检查 1 fail：BUB_API_KEY not configured
- 根因：`.env.example` 里默认空值，空值 = 未配置
- 处置：填入硅基流动 key 后全绿——**doctor 的价值 = 启动前拦截，不用跑一半才炸**
- 证据：[20260915_step8_doctor_fail_key.png](../assets/20260915_step8_doctor_fail_key.png)（fail 现场截图）

### C4 `BUB_API_BASE` doctor 不校验 ✅预防（未爆雷）
- lifecycle.toml 里它是 `required = false`，doctor 不查
- 但硅基流动场景必须设 `https://api.siliconflow.cn/v1`，否则 `openai:<模型>` 默认打 api.openai.com → 401
- 教训：**doctor 全绿 ≠ 能跑通**，可选检查项要人工过一遍
- 证据：[20260915_step8_info_tasklist.png](../assets/20260915_step8_info_tasklist.png)（info 显示 `BUB_API_BASE: missing`，而 doctor 输出里根本没有这一项）

### C5 `npx skills` 交互式选择界面 ✅解决
- 现象：装技能时弹出 79 个 agents 的多选界面
- 处置：直接 Enter 用默认（Universal `.agents/skills/` 全量包含即可，附加符号链接不需要）
- 证据：[20260915_step10_npx_skills_ui.png](../assets/20260915_step10_npx_skills_ui.png)

## D. 工程类

### D1 学习成果入库的边界 ✅解决
- 问题：workspace 整目录含 `.venv`（几百 MB 重建物）和 `.env`（密钥）
- 方案：`workspace/my_deepagent/.gitignore` 排除 `.env/.venv/__pycache__/*.egg-info/孤儿 package-lock.json`
- 提交前三重校验：`git check-ignore .env`（exit 0）+ 暂存区 grep 零命中 + 29 文件清单人工过目
- 证据：[commit d4433c4](https://github.com/rg8diaoa/deepagents-in-action/commit/d4433c4)（GitHub）｜ [workspace .gitignore](../../../../workspace/my_deepagent/.gitignore)（规则本体）

### D2 LF→CRLF 警告 ℹ️认知
- `warning: LF will be replaced by CRLF`——Windows git autocrlf 常态，非错误
- 证据：—（认知项，任何一次 git add 的运行日志均可见，未单独截图）

### D3 git clone 进度 stderr 标红 ℹ️认知
- git 把进度写 stderr，PowerShell 对 stderr 例行标红显示为"错误"——看 exit code 判断成败，别看颜色
- 证据：[20260915_step0_clone.png](../../evidence/20260915_step0_clone.png)（红色 NativeCommandError 即现场）

## 人工复盘（本人总结，非AI 代写）

1. B1–B4 四条 drift 的共同根因是什么？「权威源」应该按什么优先级排序？
2. 根因：主仓作者习惯在更新代码后先更新主要文档huo'zhe部分改进为他人贡献，dao'子目录下文档没有及时更新。\
   权威源：实测验证>xiang'mu主文档>子目录下wen'dang。
3. <br />
4. A2 的定位用了"对照实验"（复制 uv.exe 作对照组）——这个方法还能用在什么场景？
5. 除了uv.exe排查还适用于任何沙箱内异常报错的排查，因为沙箱是有隔离限制的环境。
6. <br />
7. 用自己的话各重述 C2/C3/C4 对应的原则（路径前缀 / 空值语义 / 全绿≠通过），并各举一个**今晚之外**的新例子（迁移验证；直接抄 AI 解释不算过）
8. C2：一个服务监听一个**端口**（18088），端口下面可以挂多条**路径，必须使用正确的路径去判断。**\
   C3：key值为空时不应是健康状态，这就是doctor检查存在的意义。\
   C4：doctor检查仅检查”需要的部分“是否都存在，但部分值的有效性不做检查，必须人工检查。
