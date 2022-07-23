Function Test-Pingable{
    
    <#
    .SYNOPSIS
    This function determines whether a list of computers are pingable
    .DESCRIPTION
    This function determines whether a list of computers are pingable
    .PARAMETER Name
    The name of the devices to be tested
    #>

    [CmdletBinding()]
    param (
        [Parameter(mandatory,position=0)]
        [System.Object] $Name
    )

    $connectedDevices = New-Object System.Collections.ArrayList

    foreach ($computer in $name) {

        try{

            $status = Test-Connection $computer -ErrorAction Stop

            if ($status[0].status -like "Success"){
                $obj = [PSCustomObject]@{
                    Name = $computer
                    IP = $status[0].address
                    Status = "Success"
                }
            } else {
                $obj = [PSCustomObject]@{
                    Name = $computer
                    IP = $status[0].address
                    Status = "Failure"
                }
            }
        }
        catch {
            $obj = [PSCustomObject]@{
                Name = $computer
                IP = $status[0].address
                Status = "Failure"
            }
        }

        $obj
    }
}
