#Requires -Version 5.1

# link vim files and install plugins
$ErrorActionPreference = 'Stop'

$BaseDir = $PSScriptRoot
$ConfigDir = Join-Path $env:LOCALAPPDATA 'nvim'
New-Item -ItemType Directory -Force -Path $ConfigDir | Out-Null

function New-ConfigLink {
  param(
    [string]$Source,
    [string]$Target
  )

  $existing = Get-Item -LiteralPath $Target -Force -ErrorAction SilentlyContinue
  if ($existing) {
    if ($existing.LinkType) {
      # existing link (symlink, junction or hardlink): replace it
      $existing.Delete()
    } else {
      # real file/dir: back it up instead of deleting it
      $backup = "$Target.bak"
      Write-Warning "$Target already exists, moving it to $backup"
      Move-Item -LiteralPath $Target -Destination $backup -Force
    }
  }

  $isDir = Test-Path -LiteralPath $Source -PathType Container
  try {
    # symlinks need admin rights or Developer Mode enabled
    New-Item -ItemType SymbolicLink -Path $Target -Target $Source | Out-Null
  } catch {
    # fall back to link types that don't need elevation
    if ($isDir) {
      New-Item -ItemType Junction -Path $Target -Target $Source | Out-Null
    } else {
      New-Item -ItemType HardLink -Path $Target -Target $Source | Out-Null
    }
  }
  Write-Host "Linked $Target -> $Source"
}

New-ConfigLink -Source (Join-Path $BaseDir 'init.lua') -Target (Join-Path $ConfigDir 'init.lua')
New-ConfigLink -Source (Join-Path $BaseDir 'lua') -Target (Join-Path $ConfigDir 'lua')
