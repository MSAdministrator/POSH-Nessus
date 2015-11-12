<#
.Synopsis
   This function finds the history ID of a scan
.DESCRIPTION
   This function takes a ScanID as input and finds History_ID of a specific ScanID.  The result of this function
   should be used in conjunction with Get-NessusScanHistory function
.EXAMPLE
   Get-NessusHistoryId -ScanID '1234'
#>
function Get-NessusHistoryId
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [string]$ScanID
    )

    Begin
    {
        $HistoryID = @{}
	    $Response = Enter-NessusSession -Get -Resource "/scans/$ScanID"
    }
    Process
    {
        foreach ($History in $Response.history)
	    {
		    $HistoryID.Add($History.uuid, $History.history_id)
	    }
    }
    End
    {
        return $HistoryID
    }
}