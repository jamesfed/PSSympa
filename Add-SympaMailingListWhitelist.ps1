function Add-SympaMailingListWhitelist
{

<#
.Synopsis
   This function adds a member(s) to a Mailing list
.EXAMPLE
   Add the member jim.bob@queens.ox.ac.uk to the mailing list whitelist queens-it

   Add-SympaMailingListWhitelist -Sympa $Sympa -MailingList queens-it -Member jim.bob@queens.ox.ac.uk
.EXAMPLE
   Add the members jim.bob@queens.ox.ac.uk and jim.kirk@queens.ox.ac.uk to the mailing list whitelist queens-it
   
   Add-SympaMailingListWhitelist -Sympa $Sympa -MailingList queens-it -Member @('jim.bob@queens.ox.ac.uk','jim.kirk@queens.ox.ac.uk')
.EXAMPLE
    Get the members from the list whitelist queens-test and add them to queens-it

    Get-SympaMailingListWhitelist -Sympa $Sympa -MailingList queens-test | Add-SympaMailingListWhitelist -Sympa $sympa -MailingList queens-it
#>

param(

    [Parameter(Mandatory=$true,HelpMessage="Pass in the result of the 'Get-SympaLogin' function")]
    $Sympa,

    [Parameter(Mandatory=$true,HelpMessage="Enter the name of the Mailing list you want to add the whitelist member(s) to")]
    [String]$MailingList,

    [Parameter(Mandatory=$true,HelpMessage="Enter the address of the member(s) you want to add to the Mailling list whitelist",ValueFromPipelineByPropertyName=$True)]
    [Array]$Member

    )
    
    Process{
        #Loop over the member(s) and add them to the list
        foreach($Address in $Member){
            try
            {
                Write-Verbose "Adding $Address to $MailingList"
                $Sympa.addWhitelist("$MailingList","$Address", "","1")   
            }
            catch
            {
            
            }
        }
    }
}