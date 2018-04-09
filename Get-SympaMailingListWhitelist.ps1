﻿function Get-SympaMailingListWhitelist
{

<#
.Synopsis
   This function returns the whitelist of a Mailing list(s)
.EXAMPLE
   Get-SympaMailingListWhitelist -Sympa $Sympa -MailingList queens-it
.EXAMPLE
   Get-SympaMailingListWhitelist -Sympa $Sympa -MailingList @('queens-it','queens-undergrads')
#>

param(

    [Parameter(Mandatory=$true,HelpMessage="Pass in the result of the 'Get-SympaLogin' function")]
    $Sympa,
    [Parameter(Mandatory=$true,HelpMessage="Enter the name of the Mailing list(s) you want to return the whitelist member(s) of",ValueFromPipelineByPropertyName=$True)]
    [Array]$MailingList

    )
    
    #Create empty collection
    $Output = New-Object System.Collections.ArrayList

    #Loop over the mailing lists provided
    foreach($MailList in $MailingList){
        
        $Results = $Sympa.getWhitelist("$MailList")

        #Parse the list into objects (Sympa only returns a big long string with line breaks)
        foreach($Result in $Results){

            #Build an object to store the results in
            $Item = New-Object -TypeName System.Object

            #Add the members to the object
            $Item | Add-Member -MemberType NoteProperty -Name "MailingList" -Value $MailList
            $Item | Add-Member -MemberType NoteProperty -Name "Member" -Value $Result

            #Add the object to the collection
            $Output.Add($Item) | Out-Null
        }
    }

    #Return the output as a Collection
    Return $Output
}