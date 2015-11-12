<#
.Synopsis
   This function gets Nessus scan history based on the ScanID and HistoryID
.DESCRIPTION
   This function gets Nessus all scan history for a specific Scan and History ID
.EXAMPLE
   Get-NessusScanHistory -ScanID '1234' -HistoryID '5678'
#>
function Get-NessusScanReport
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [string]$ScanID,

        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [string]$FileID
    )

    Begin
    {
        
    }
    Process
    {
        $Response = Enter-NessusSession -Get -Resource "/scans/$ScanID/export/$FileID/download"
        $File = "nessus-$ScanID-$FileID.nessus"
        Write-Verbose "Saving Report to $File"
        $Response.OuterXml | Out-File $File
    }
    End
    {
        
    }
}