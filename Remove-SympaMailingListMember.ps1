﻿function Remove-SympaMailingListMember
{

<#
.Synopsis
   This function removes a member(s) from a Mailing list
.EXAMPLE
   Remove the member jim.bob@queens.ox.ac.uk from the mailing list queens-it

   Remove-SympaMailingListMember -Sympa $Sympa -MailingList queens-it -Member jim.bob@queens.ox.ac.uk
.EXAMPLE
   Remove the members jim.bob@queens.ox.ac.uk and jim.kirk@queens.ox.ac.uk from the mailing list queens-it
   
   Remove-SympaMailingListMember -Sympa $Sympa -MailingList queens-it -Member @('jim.bob@queens.ox.ac.uk','jim.kirk@queens.ox.ac.uk')
.EXAMPLE
   Remove all of the members from the queens-it mailling list

   Get-SympaMailingListMember -Sympa $sympa -MailingList queens-it | Remove-SympaMailingListMember -Sympa $sympa -MailingList queens-it
.Example
   Remove members from the list queens-it as defined in a CSV

   Import-Csv C:\Sympa\queens-it-memberslist.csv | Remove-SympaMailingListMember -Sympa $sympa -MailingList queens-it
#>

param(

    [Parameter(Mandatory=$true,HelpMessage="Pass in the result of the 'Get-SympaLogin' function")]
    $Sympa,
    [Parameter(Mandatory=$true,HelpMessage="Enter the name of the Mailing list you want to remove the member(s) from")]
    [String]$MailingList,
    [Parameter(Mandatory=$true,HelpMessage="Enter the address of the member(s) you want to remove from the Mailling list",ValueFromPipelineByPropertyName=$True)]
    [Array]$Member
<#
    [Parameter(Mandatory=$false,HelpMessage="Should you notify the user that they are being removed from the list, default is no")]
    [ValidateSet("Yes", "No")]
    [String]$Notify = "No"
#>
    )
<#    
    #Handle the $Notify paramater converting it into the mess that Sympa understands
    switch ($Notify)
    {
        'Yes' {$Alert = "0"}
        'No' {$Alert = "1"}
        Default {$Alert = "1"}
    }
#>

    Process{
        #Loop over the member(s) and remove them from the list
        foreach($Address in $Member){
            try
            {
                Write-Verbose "Removing $Address from $MailingList"
                $Sympa.del("$MailingList","$Address",'1')    
            }
            catch
            {
            
            }
        }
    }
}