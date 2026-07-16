# Builds dist/orchestration-playbook-v1.0.zip from product/ + templates/ + docs/method.md
# Run from repo root: pwsh scripts/build-zip.ps1
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$stage = Join-Path $root 'dist\stage\orchestration-playbook'
$zip = Join-Path $root 'dist\orchestration-playbook-v1.0.zip'

if (Test-Path (Join-Path $root 'dist')) { Remove-Item (Join-Path $root 'dist') -Recurse -Force }
New-Item -ItemType Directory -Force $stage | Out-Null

Copy-Item (Join-Path $root 'product\*') $stage -Recurse
Copy-Item (Join-Path $root 'templates') (Join-Path $stage 'templates') -Recurse
Copy-Item (Join-Path $root 'docs\method.md') (Join-Path $stage 'method.md')
Copy-Item (Join-Path $root 'LICENSE') (Join-Path $stage 'templates\LICENSE')

# Verify the zip contents match the promises in README-START-HERE.md
$must = @(
  'README-START-HERE.md', 'checklists.md', 'method.md',
  'worked-example-1-three-worker-build.md', 'worked-example-2-cold-session-recovery.md',
  'playbook\00-introduction.md', 'playbook\09-failure-modes.md',
  'playbook\10-appendix-a-reference-files.md', 'playbook\11-appendix-b-wiring.md',
  'templates\task.md', 'templates\context.md', 'templates\log.md',
  'templates\worker-brief.md', 'templates\worker-result.md'
)
$missing = $must | Where-Object { -not (Test-Path (Join-Path $stage $_)) }
if ($missing) { throw "zip incomplete, missing: $($missing -join ', ')" }
$chapters = (Get-ChildItem (Join-Path $stage 'playbook') -Filter '*.md').Count
if ($chapters -ne 12) { throw "expected 12 playbook files (00-11), found $chapters" }

Compress-Archive -Path (Join-Path $root 'dist\stage\*') -DestinationPath $zip -Force
Remove-Item (Join-Path $root 'dist\stage') -Recurse -Force
$size = [math]::Round((Get-Item $zip).Length / 1KB, 1)
Write-Host "OK: $zip ($size KB, $chapters playbook files, all promised paths present)"
