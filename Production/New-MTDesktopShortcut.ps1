
Function New-MTDesktopShortcut{

    <#
    .SYNOPSIS
    Removes the old shortcut, if specified, and adds a new shortcut
    .DESCRIPTION
    This cmdlet removes the old shortcut from the specified path, and creates a new shortcut on the public desktop. If you specify an old shortcut is removed before creating
    a new shortcut, and the old shortcut can't be removed, the cmdlet exits without creating the new shortcut. 
    .PARAMETER $NewShortcutPath
    The path opened by the new shortcut. Ex. https:\\www.google.com
    .PARAMETER $NewShortcutName
    The name displayed on the new shortcut icon. Ex. 'Google Shortcut'
    .PARAMETER $OldShortcutPath
    The UNC path to the shortcut. Ex. C:\users\public\desktop\google.url
    .EXAMPLE
    Update-DesktopShortcut -OldShortcutPath "C:\users\public\Deskop\google.url" -NewShortcutPath "http://www.duckduckgo.com" -NewShortcutName "DuckDuckGo" -Verbose
    .NOTES
    #>

    param (
        [Parameter(ValueFromPipelineByPropertyName=$True, Mandatory=$True)]
        [String] $NewShortcutPath,
        [Parameter(ValueFromPipelineByPropertyName=$True, Mandatory=$True)]
        [String] $NewShortcutName,
        [Parameter(ValueFromPipelineByPropertyName=$True, Mandatory=$False)]
        [String] $OldShortcutPath
    )

    BEGIN {}

    PROCESS {

        # REMOVE OLD SHORTCUT
        if ($PSBoundParameters.ContainsKey('OldShortcutPath')) {

            Try {
                Write-Verbose -Message "Testing whether $OldShortcutPath exits"
                Test-Path -Path $OldShortcutPath -ErrorAction Stop | Out-Null
                Write-Verbose -Message "$OldShortcutPath exits"
                $OldShortcutPathExits=$True
            } Catch {
                Write-Warning -Message "$OldShortcutPath doesn't exist"
                $OldShortcutPathExits=$False
            }

            if ($OldShortcutPathExits=$True){
                Try {
                    Write-Verbose -Message "Attempting to remove $OldShortcutPath"
                    Remove-Item $OldShortcutPath -ErrorAction Stop
                    Write-Verbose -Message "$OldShortcutPath removed successfully"
                } Catch {
                    Write-Warning -Message "Unable to remove $OldShortcutPath"
                    Write-Verbose -Message "Exiting without creating $NewShortcutName shortcut"
                    #exit
                }
            }
        }

        # ADD NEW SHORTCUT
        Try {
            Write-Verbose -Message "Attempting to create a new shortcut"
            $wshShell = New-Object -ComObject "WScript.Shell" -ErrorAction Stop
            $urlPath = Join-Path $wshShell.SpecialFolders.Item("AllUsersDesktop") "$NewShortcutName.url" -ErrorAction Stop
            $urlShortcut = $wshShell.CreateShortcut($urlPath)   
            $urlShortcut.TargetPath = $NewShortcutPath
            $urlShortcut.Save()
            Write-Verbose -Message "$NewShortcutName successfully created"
        } Catch {
            Write-Warning -Message "Unable to create $NewShortcutName"
            Write-Verbose -Message "Exiting without creating $NewShortcutName shortcut"
            #exit
        }
    }

    END {}
}