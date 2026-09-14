# Workaround wrapper: agentseek.exe (uv trampoline) fails to launch on this
# machine with 0xC0000135 (DLL not found). Invoke the CLI through the tool
# venv's python instead. Usage: .\learn\infra\agentseek.ps1 version
$py = Join-Path $env:APPDATA "uv\tools\agentseek\Scripts\python.exe"
if (-not (Test-Path $py)) { Write-Error "tool venv python not found: $py"; exit 1 }
& $py -m agentseek @args
exit $LASTEXITCODE
