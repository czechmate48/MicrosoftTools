Function Uninstall-AutoLogin{

<#
.SYNOPSIS
Edits the registry to allow for automatic log in
.DESCRIPTION
Edits the registry to allow for automatic log in. Removes login information for an administrator account
.PARAMETER logPath
Optional. Used for logging the process in a text file
.EXAMPLE
Uninstall-AutoLogin -logPath "C:\users\user\
.LINK
Install-AutoLogin
#>

    [CmdletBinding()]
    param ()

    $regPath = "HKLM:\SOFTWARE\Microsoft\WINDOWS NT\CurrentVersion\Winlogon"

    #USERNAME
    try{
        Remove-RegistryItem -path $regPath -name "DefaultUserName"
        Write-Verbose "SUCCESS: DefaultUserName removed from registry" 
    }
    catch{
        Write-Verbose "ERROR: DefaultUserName not removed from registry" 
    }

    #PASSWORD
    try{
        Remove-RegistryItem -path $regPath -name "DefaultPassword"
        Write-Verbose "SUCCESS: DefaultPassword removed from registry"
    }
    catch{
        Write-Verbose "ERROR: DefaultPassword not removed from registry"
    }

    #AUTO LOGIN
    try{
        Remove-RegistryItem -path $regPath -name "AutoAdminLogon"
        Write-Verbose "SUCCESS: AutoAdminLogon removed from registry"
    }
    catch{
        Write-Verbose "ERROR: AutoAdminLogon not removed from registry"
    }

}
