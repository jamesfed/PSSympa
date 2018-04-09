﻿function Add-SympaMailingListMember
{

<#
.Synopsis
   This function adds a member(s) to a Mailing list
.EXAMPLE
   Add the member jim.bob@queens.ox.ac.uk to the mailing list queens-it

   Add-SympaMailingListMember -Sympa $Sympa -MailingList queens-it -Member jim.bob@queens.ox.ac.uk
.EXAMPLE
   Add the members jim.bob@queens.ox.ac.uk and jim.kirk@queens.ox.ac.uk to the mailing list queens-it
   
   Add-SympaMailingListMember -Sympa $Sympa -MailingList queens-it -Member @('jim.bob@queens.ox.ac.uk','jim.kirk@queens.ox.ac.uk')
.EXAMPLE
    Get the members from the list queens-test and add them to queens-it

    Get-SympaMailingListMember -Sympa $Sympa -MailingList queens-test | Add-SympaMailingListMember -Sympa $sympa -MailingList queens-it
#>

param(

    [Parameter(Mandatory=$true,HelpMessage="Pass in the result of the 'Get-SympaLogin' function")]
    $Sympa,

    [Parameter(Mandatory=$true,HelpMessage="Enter the name of the Mailing list you want to add the member(s) to")]
    [String]$MailingList,

    [Parameter(Mandatory=$true,HelpMessage="Enter the address of the member(s) you want to add to the Mailling list",ValueFromPipelineByPropertyName=$True)]
    [Array]$Member
<#
    [Parameter(Mandatory=$false,HelpMessage="Should you notify the user that they are being added to the list, default is no")]
    [ValidateSet("Yes", "No")]
    [String]$Notify = "No"
#>
    )
    
<#
    #Handle the $Notify paramater converting it into the mess that Sympa understands
    switch ($Notify)
    {
        'Yes' {$Alert = "false"}
        'No' {$Alert = "true"}
        Default {$Alert = "true"}
    }
#>

    Process{
        #Loop over the member(s) and add them to the list
        foreach($Address in $Member){
            try
            {
                Write-Verbose "Adding $Address to $MailingList"
                $Sympa.add("$MailingList","$Address", "","1")   
            }
            catch
            {
            
            }
        }
    }
}