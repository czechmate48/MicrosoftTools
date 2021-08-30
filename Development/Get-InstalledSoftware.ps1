

Function Get-InstalledSoftware {
<#
.SYNOPSIS
.DESCRIPTION

.PARAMETER $Type
 App -> These software programs have a .msix or .appx file name extension. These are files installed using the Microsoft windows package manager (AppxPackage). 
 NOTE that powershell 7 does not support the Appx Module, so this information is queried using Windows Powershell (Import-Module Appx -UseWindowsPowershell)
.PARAMETER $GroupType
.EXAMPLE
.EXAMPLE
.NOTES
See Add-AppxPackage, Get-AppxPackageManifest, Move-AppxPackage, & Remove-AppxPackage for details on managing microsoft store apps
#>

    [Cmdletbinding()]
    Param (
        [Parameter(ValueFromPipelineByPropertyName=$True)]
        [ValidateSet('App','All')]
        [String] $Type="All"
    )

    BEGIN{}
    PROCESS {
        if ($Type -eq "App" -or $Type -eq "All"){
            # FIXME -> Failing every other time this part of the cmdlet is called from same powershell window
    
            Try {
                Write-Verbose -Message "Installing Appx Module"
                Import-Module Appx -UseWindowsPowershell -Force -ErrorAction Stop
            } Catch {
                Write-Error -Message "Unable to import Appx module, software of type 'App' will be excluded from results (.msix, .appx)"
            }
            
            Get-AppxPackage -AllUsers
        }
    }
    END {}

}