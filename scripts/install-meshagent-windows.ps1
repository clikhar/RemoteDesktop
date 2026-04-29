param(
  [Parameter(Mandatory=$true)]
  [string]$AgentUrl
)

$ErrorActionPreference = 'Stop'
$TempDir = Join-Path $env:TEMP ("meshagent-" + [guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $TempDir | Out-Null
$AgentPath = Join-Path $TempDir 'meshagent.exe'

Invoke-WebRequest -Uri $AgentUrl -OutFile $AgentPath
Start-Process -FilePath $AgentPath -ArgumentList '-fullinstall' -Verb RunAs -Wait

Write-Host 'MeshAgent installed. Verify in MeshCentral device list.'
