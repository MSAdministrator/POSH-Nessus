<#
.Synopsis
   Login to Nessus API
.DESCRIPTION
   This function is used to login to the Nessus API using your credentials
.EXAMPLE
   New-NessusLogin -Credential $credential
.INPUTS
   This function takes a credential object as an input
.OUTPUTS
   This function returns a Nessus session token
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function New-NessusLogin
{
    [CmdletBinding(SupportsShouldProcess=$true)]
    Param
    (
        # Param1 help description
        [parameter(Mandatory = $true,
                   ValueFromPipeline = $true,
                   ValueFromPipelineByPropertyName = $true,
        HelpMessage = 'Please provide a credential obejct')]
        [ValidateNotNullOrEmpty()]
        [System.Management.Automation.CredentialAttribute()]$credential
    )

    Begin
    {
        $data = @{"username" = $($credential.UserName); "password" = $($credential.GetNetworkCredential().password) }
    }
    Process
    {
	    $Result = Enter-NessusSession -Post -Resource "/session" -Data $data 
    }
    End
    {
        return $Result.token
    }
}