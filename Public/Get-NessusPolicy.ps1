
<#
.Synopsis
   This function returns all available Nessus Policies
.DESCRIPTION
   This function returns all Nessus Policy Titles and their UUID
.EXAMPLE
   Get-NessusPolicy
#>
function Get-NessusPolicy
{
    [CmdletBinding()]
    Param()

    Begin
    {
        $Result = @{}
	    $Response = Enter-NessusSession -Get -Resource "/editor/policy/templates"
    }
    Process
    {
        foreach ($Policy in $Response.templates)
	    {
		    $Result.Add($Policy.title, $Policy.uuid)
	    }
    }
    End
    {
        return $Result
    }
}