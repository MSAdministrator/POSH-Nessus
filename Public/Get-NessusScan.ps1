<#
.Synopsis
   This function gets Nessus scan history based on the ScanID and HistoryID
.DESCRIPTION
   This function gets Nessus all scan history for a specific Scan and History ID
.EXAMPLE
   Get-NessusScanHistory -ScanID '1234' -HistoryID '5678'
#>
function Get-NessusScan
{
    [CmdletBinding()]
    Param()

    Begin
    {
        $Scans = @{}
	    $Response = Enter-NessusSession -Get -Resource "/scans"
    }
    Process
    {
        foreach ($scan in $Response.scans){
		$Scans.add($scan.id, $scan.name)
	}
    }
    End
    {
        return $Scans
    }
}