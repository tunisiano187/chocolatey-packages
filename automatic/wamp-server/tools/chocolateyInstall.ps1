﻿$packageName      = $env:ChocolateyPackageName
$installerType    = 'EXE'
$url32            = 'http://wampserver.aviatechno.net/files/install/wampserver3.2.0_x86.exe'
$url64            = 'http://wampserver.aviatechno.net/files/install/wampserver3.2.0_x64.exe'
$checksum32Type   = 'sha256'
$checksum64Type   = 'sha256'
$checksum32       = '921f2815298ff5b6f965505da9b74f517cddeae6bc3c0508449a6fa62edd952b'
$checksum64       = '9a89260d4240b938fbcf9d98f29c27e527ac104f8ba67453be94bcd73b54df7a'
$silentArgs       = '/DIR="C:\wamp" /VERYSILENT /SUPPRESSMSGBOXES'
$validExitCodes   = @(0)

$packageArgs = @{
  packageName     = $packageName
  fileType        = $installerType
  url             = $url32
  url64			      = $url64
  silentArgs      = $silentArgs
  validExitCodes  = $validExitCodes
  softwareName    = 'wamp-server*'
  checksum        = $checksum32
  checksum64      = $checksum64
  checksumType    = $checksum32type
  checksum64Type  = $checksum64type
}

#if([System.Environment]::Is64BitOperatingSystem) {
#  $installahk   = 'chocolateyInstall64.ahk'
#} else {
#  $installahk   = 'chocolateyInstall.ahk'
#}

#$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$ahkFile = Join-Path $scriptPath $installahk
#$ahkExe = 'AutoHotKey'
#$ahkRun = "$Env:Temp\$(Get-Random).ahk"
#Copy-Item $ahkFile "$ahkRun" -Force
#Start-Process $ahkExe $ahkRun

#$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$ahkFile = Join-Path $scriptPath "chocolateyLang.ahk"
#$ahkExe = 'AutoHotKey'
#$ahkRun = "$Env:Temp\$(Get-Random).ahk"
#Copy-Item $ahkFile "$ahkRun" -Force
#Start-Process $ahkExe $ahkRun

Install-ChocolateyPackage @packageArgs
