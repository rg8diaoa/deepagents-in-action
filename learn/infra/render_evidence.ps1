# Render a plain-text command-output evidence file into a terminal-style PNG.
# Usage: .\learn\infra\render_evidence.ps1 -InputFile <txt> -OutputFile <png>
param(
  [Parameter(Mandatory = $true)][string]$InputFile,
  [Parameter(Mandatory = $true)][string]$OutputFile
)
Add-Type -AssemblyName System.Drawing
$lines = [System.IO.File]::ReadAllLines((Resolve-Path $InputFile), [System.Text.Encoding]::UTF8)
if ($lines.Count -eq 0) { $lines = @("(empty)") }
$fontSize = 13
$font = New-Object System.Drawing.Font("Microsoft YaHei UI", $fontSize)
$lineH = [int]($fontSize * 1.7)
$pad = 18
$measure = [System.Drawing.Graphics]::FromImage((New-Object System.Drawing.Bitmap(1, 1)))
$maxW = 0
foreach ($l in $lines) { $w = $measure.MeasureString($l, $font).Width; if ($w -gt $maxW) { $maxW = $w } }
$width = [int][Math]::Min(1800, [Math]::Max(460, $maxW + $pad * 2))
$height = [int]($lines.Count * $lineH + $pad * 2)
$bmp = New-Object System.Drawing.Bitmap($width, $height)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$bg = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(24, 24, 27))
$fg = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(214, 214, 214))
$ok = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(134, 220, 148))
$err = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(240, 150, 140))
$g.FillRectangle($bg, 0, 0, $width, $height)
$y = $pad
foreach ($l in $lines) {
  $brush = $fg
  if ($l -match '^(===|---|PS |>)') { $brush = $ok }
  if ($l -match '(error|fail|Traceback|Sandbox Error|0xC0000135|exit: -|NativeCommandError)') { $brush = $err }
  $g.DrawString($l, $font, $brush, $pad, $y)
  $y += $lineH
}
$bmp.Save($OutputFile, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose(); $bmp.Dispose(); $measure.Dispose()
Write-Output ("saved: {0} ({1}x{2})" -f $OutputFile, $width, $height)
