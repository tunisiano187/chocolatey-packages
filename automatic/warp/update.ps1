﻿$ErrorActionPreference = 'Stop'
import-module au

$releases = "https://1.1.1.1/Cloudflare_WARP_Release-x64.msi"

function Get-Version($name) {
	$version_file=$(../../tools/Get-InstalledApps.ps1 -ComputerName $env:COMPUTERNAME -NameRegex $name).DisplayVersion
	while($version_file.count -eq 0)
	{
		$version_file=$(../../tools/Get-InstalledApps.ps1 -ComputerName $env:COMPUTERNAME -NameRegex $name).DisplayVersion
		Start-Sleep -Seconds 1
	}
	return $version_file
}

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
     }
}

function global:au_GetLatest {
	$url64=$releases

    $File = Join-Path $env:TEMP "warp.msi"
	Invoke-WebRequest -Uri $url64 -OutFile $File
    Start-Process msiexec.exe -Wait -ArgumentList "/I $File /qn /norestart"
    $version = Get-Version("warp")

	$Latest = @{ URL64 = $url64; Version = $version }

    return $Latest
}

update -ChecksumFor 32
