﻿$ErrorActionPreference = 'Stop'
$packageName    = $env:ChocolateyPackageName
$installerType  = 'EXE'
$silentArgs     = '/qb'
$url            = 'https://www.filejuggler.com/download/filejuggler.exe'
$checksum       = 'd348b14e87a47bbdd20fe0e01072380fc4c76de82910817813ae79cebb7198ea'
$checksumtype	= 'sha256'

$scriptPath     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile        = Join-Path $scriptPath "chocolateyInstall.ahk"
$ahkExe         = 'AutoHotKey'
$ahkRun         = "$Env:Temp\$(Get-Random).ahk"

Copy-Item $ahkFile "$ahkRun" -Force
Start-Process $ahkExe $ahkRun

Install-ChocolateyPackage $packageName $installerType $silentArgs $url -checksum $checksum -ValidExitCodes @(0,1223) -ChecksumType $checksumtype
