<#
.Synopsis
   Enter-NessusSession is the core functionality of the POSH-Nessus Module
.DESCRIPTION
   This function sets, removes, retrieves, etc. data from your internal Nessus server
.EXAMPLE
   Enter-NessusSession -Method "Post" -Resource "/session" -Data $data 
.EXAMPLE
   Enter-NessusSession -Method "Get" -Resource "/editor/policy/templates"
.INPUTS
   Inputs to this cmdlet (if any)
.OUTPUTS
   Output from this cmdlet (if any)
.NOTES
   General notes
.COMPONENT
   The component this cmdlet belongs to
.ROLE
   The role this cmdlet belongs to
.FUNCTIONALITY
   The functionality that best describes this cmdlet
#>
function Verb-Noun
{
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1', 
                  SupportsShouldProcess=$true)]
    [OutputType([String])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()] 
        [string]$Server,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()] 
        [string]$Port,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,  
                   Position=0,
                   ParameterSetName='Get')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()] 
        [switch]$Get,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,  
                   Position=0,
                   ParameterSetName='Set')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()] 
        [switch]$Set,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,  
                   Position=0,
                   ParameterSetName='Delete')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()] 
        [switch]$Delete,

        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,  
                   Position=0,
                   ParameterSetName='Post')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()] 
        [switch]$Post,
        
        [Parameter(Mandatory=$true, 
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()] 
        [string]$Resource,

        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='Set')]
        [ValidateNotNull()]
        [ValidateNotNullOrEmpty()]
        [hashtable]$Data = @{}
    )

    Begin
    {
        $BaseUrl = "https://$($Server):$($Port)"
        $Header = @{"X-Cookie" = "token=$token"}
	    $URL = $BaseUrl + $Resource
    }
    Process
    {
        # Use an empty dictionary for the body on GET requests
	    if ($Get)
        {
		    $Body = @{}
            $Method = 'Get'
	    }
        if ($Set)
        {
		    $Body = ConvertTo-Json $data
            $Method = 'Set'
	    }
        if ($Delete)
        {
            $Method = 'Delete'
        }
        if ($Post)
        {
            $Method = 'Post'
        }

	    $Result = Invoke-RestMethod -Uri $URL -ContentType "application/json" -Method $Method -Headers $Header -Body $Body

    }
    End
    {
        return $Result
    }
}