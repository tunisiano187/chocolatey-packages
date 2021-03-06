﻿$ErrorActionPreference = 'Stop'
import-module au

$releases = 'https://github.com/gramps-project/gramps/releases/latest'

function global:au_SearchReplace {
	@{
		'tools/chocolateyInstall.ps1' = @{
			"(^[$]url\s*=\s*)('.*')"      		= "`$1'$($Latest.URL32)'"
			"(^[$]checksum\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumtype\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType32)'"
            "(^[$]url64\s*=\s*)('.*')"      		= "`$1'$($Latest.URL64)'"
			"(^[$]checksum64\s*=\s*)('.*')" 		= "`$1'$($Latest.Checksum64)'"
			"(^[$]checksumType64\s*=\s*)('.*')" 	= "`$1'$($Latest.ChecksumType64)'"
		}
	}
}

function global:au_GetLatest {
	Write-Output 'Check Folder'
	$installer = ((Invoke-WebRequest -Uri $releases -UseBasicParsing).Links | Where-Object {$_ -match '.exe'} | Sort-Object -Descending).href
	$installer32 = $installer | Where-Object {$_ -match 'win32'} | Select-Object -First 1
	$installer64 = $installer | Where-Object {$_ -match 'win64'} | Select-Object -First 1
	Write-Output 'Checking version'
	$version=$($installer[0]).split('O')[-1].split('_')[0].trim().substring(1).replace('-','.')

	Write-Output "Version : $version"
	$url32 = "https://github.com$($installer32)";
	$url64 = "https://github.com$($installer64)";

	if($version -eq '5.1.3.2') {
		$version = '5.1.3.3'
	}

	$Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
	return $Latest
}

update -NoCheckChocoVersion