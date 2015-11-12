<#
.Synopsis
   This function gets Nessus scan history based on the ScanID and HistoryID
.DESCRIPTION
   This function gets Nessus all scan history for a specific Scan and History ID
.EXAMPLE
   Get-NessusScanHistory -ScanID '1234' -HistoryID '5678'
#>
function Set-NessusScanData
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [string]$Name,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [string]$Description,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [string]$Target,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [string]$Policy
    )

    Begin
    {
        $settings = @{}
	    $settings.Add("name", $Name)
	    $settings.Add("description", $Description)
	    $settings.Add("text_targets", $Target)

	    $data = @{}
	    $data.Add("uuid", $Policy)
	    $data.Add("settings", $settings)
    }
    Process
    {
        $Response = Enter-NessusSession -Post -Resource "/scans" -Data $data
    }
    End
    {
        return $Response.Scan
    }
}






