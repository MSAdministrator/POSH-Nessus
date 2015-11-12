<#
.Synopsis
   This function gets Nessus scan history based on the ScanID and HistoryID
.DESCRIPTION
   This function gets Nessus all scan history for a specific Scan and History ID
.EXAMPLE
   Get-NessusScanHistory -ScanID '1234' -HistoryID '5678'
#>
function Invoke-NessusScan
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [string]$ScanID
    )

    Begin
    {
        
    }
    Process
    {
        $Response = Enter-NessusSession -Post -Resource "/scans/$ScanID/launch"
    }
    End
    {
        return $Response.scan_uuid
    }
}