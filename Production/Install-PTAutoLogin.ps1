Function Install-PTAutoLogin {

     <#
	.SYNOPSIS
	Edits the registry to allow for automatic log in
	.DESCRIPTION
	Edits the registry to allow for automatic log in. Requires an administrator user name and password
	.PARAMETER localAdminName
	Required. The name of the local administrator account. Requires password is passed in using plain text
	.PARAMETER localAdminPassword
	Required. The password of the local administrator account
	.EXAMPLE
	Install-AutoLogin -localAdminName "Administrator" -localAdminPassword "password"
	.LINK
	Uninstall-AutoLogin
    #>

    [CmdletBinding()]
    param (
	    [Parameter(Mandatory=$true)]
        [string] $localAdminName,
        [Parameter(Mandatory=$true)]
	    [string] $localAdminPassword
    )

    $regPath = "HKLM:\SOFTWARE\Microsoft\WINDOWS NT\CurrentVersion\Winlogon"

    #USERNAME
    try{
        Set-RegistryValue -path $regPath -name "DefaultUserName" -value $localAdminName
        Write-Verbose "SUCCESS: DefaultUserName set in registry"
    }
    catch{
        Write-Verbose "ERROR: DefaultUserName not set in registry"
    }

    #PASSWORD
    try{
        Set-RegistryValue -path $regPath -name "DefaultPassword" -value $localAdminPassword
        Write-Verbose "SUCCESS: DefaultPassword set in registry"
    }
    catch{
        Write-Verbose "ERROR: DefaultPassword not set in registry"
    }

    #AUTO LOGIN
    try{
        Set-RegistryValue -path $regPath -name "AutoAdminLogon" -value $true
        Write-Verbose "SUCCESS: AutoAdminLogin set in registry"
    }
    catch{
        Write-Verbose "ERROR: AutoAdminLogon not set in registry"
    }

}
