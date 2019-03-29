Function Get-SysInfo{

    [CmdletBinding()]
    param(
    [Parameter(Mandatory=$false)]
    [string]$ComputerName
    )

if([string]::IsNullOrEmpty($ComputerName))
    {
        $ComputerName = $env:COMPUTERNAME
    }

Write-Host "`n**System information for $ComputerName** `n" -ForegroundColor Yellow

$OperatingSystem = Get-CimInstance Win32_OperatingSystem -ComputerName $ComputerName | Select-Object *
$HardwareInformation = Get-CimInstance Win32_ComputerSystem -ComputerName $ComputerName | Select-Object *
$MemoryInformation = [math]::Round((Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ComputerName).TotalPhysicalMemory/1GB)
$ProcessorInformation = Get-CimInstance Win32_Processor -ComputerName $ComputerName | Select-Object *

Write-Host "System Name:"$ComputerName -ForegroundColor White
Write-Host "Manufactured by:"$HardwareInformation.Manufacturer -ForegroundColor White
Write-Host "Hardware Model:"$HardwareInformation.Model -ForegroundColor White
Write-Host "Processor:"$ProcessorInformation.Name -ForegroundColor White
Write-Host "Installed RAM:"$MemoryInformation "GB" -ForegroundColor White
Write-Host "Domain:"$HardwareInformation.Domain -ForegroundColor White
Write-Host "OS Version:"$OperatingSystem.Caption -ForegroundColor White
Write-Host "OS Architecture:"$OperatingSystem.OSArchitecture -ForegroundColor White
Write-Host "Install Date:"$OperatingSystem.InstallDate -ForegroundColor White
Write-Host "Last Boot Time:"$OperatingSystem.LastBootUpTime -ForegroundColor White
Write-Host ""
}
Export-ModuleMember -Function Get-SysInfo
