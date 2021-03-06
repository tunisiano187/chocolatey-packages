$ErrorActionPreference = 'Stop';

$packageName= 'arduino'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Get-Item "$toolsDir\*.exe"

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  file          = $fileLocation
  softwareName  = 'Arduino*'
  silentArgs    = '/S'
  validExitCodes= @(0)
}

$ahkFile = Join-Path $toolsDir "arduinoInstall.ahk"
Start-Process -FilePath 'AutoHotKey' -ArgumentList $ahkFile

Install-ChocolateyPackage @packageArgs

#Don't need installer anymore
Remove-Item $toolsDir\*.exe -ea 0 -force
