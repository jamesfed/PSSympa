function Remove-SympaMailingListWhitelist
{

<#
.Synopsis
   This function removes a member(s) from a Mailing list
.EXAMPLE
   Remove the member jim.bob@queens.ox.ac.uk from the mailing list whitelist queens-it

   Remove-SympaMailingListWhitelist -Sympa $Sympa -MailingList queens-it -Member jim.bob@queens.ox.ac.uk
.EXAMPLE
   Remove the members jim.bob@queens.ox.ac.uk and jim.kirk@queens.ox.ac.uk from the mailing list whitelist queens-it
   
   Remove-SympaMailingListWhitelist -Sympa $Sympa -MailingList queens-it -Member @('jim.bob@queens.ox.ac.uk','jim.kirk@queens.ox.ac.uk')
.EXAMPLE
   Remove all of the members from the queens-it mailling list whitelist

   Get-SympaMailingListWhitelist -Sympa $Sympa -MailingList queens-it | Remove-SympaMailingListWhitelist -Sympa $Sympa -MailingList queens-it
.Example
   Remove members from the list whitelist queens-it as defined in a CSV

   Import-Csv C:\Sympa\queens-it-memberslist.csv | Remove-SympaMailingListWhitelist -Sympa $Sympa -MailingList queens-it
#>

param(

    [Parameter(Mandatory=$true,HelpMessage="Pass in the result of the 'Get-SympaLogin' function")]
    $Sympa,
    [Parameter(Mandatory=$true,HelpMessage="Enter the name of the Mailing list you want to remove the member(s) from")]
    [String]$MailingList,
    [Parameter(Mandatory=$true,HelpMessage="Enter the address of the member(s) you want to remove from the Mailling list",ValueFromPipelineByPropertyName=$True)]
    [Array]$Member
    )

    Process{
        #Loop over the member(s) and remove them from the list
        foreach($Address in $Member){
            try
            {
                Write-Verbose "Removing $Address from $MailingList whitelist"
                $Sympa.delWhitelist("$MailingList","$Address")    
            }
            catch
            {
            
            }
        }
    }
}