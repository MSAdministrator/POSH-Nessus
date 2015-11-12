<#
.Synopsis
   Exit Nessus API session
.DESCRIPTION
   This function is used to exit an Nessus API session
.EXAMPLE
   Exit-NessusSession
#>
function Exit-NessusSession
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    Param()

    Begin
    {
    }
    Process
    {
	    $Result = Enter-NessusSession -Delete -Resource "/session"
    }
    End
    {
        return $Result
    }
}