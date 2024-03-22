.SYNOPSIS
  Sync specific devices
.DESCRIPTION
SEARCHING FOR THE EMAIL THEN Syncing Each device associated with the emailaddress of user.
#Created By: Estefon Marrero
#Date Created: 3/7/2023
.NOTES
  Version: V1
  Author: Estefon Marrero
  Revised: 3/21/2024
#####################################################################################

$emailAddresses = Import-Csv "PATH OF CSV FILE"

#Will loop through every email in the CSV file
ForEach ($user in $emailAddresses) {
    #Get Device info based off email address
    $DeviceInfo = Get-MgDeviceManagementManagedDevice -Filter "emailAddress eq '$($user.emailAddress)'"    
    
    if ($DeviceInfo){ #If the user has devices it will show the results below.

        Write-Host "Found Devices for $($user.emailAddress)." `n 

#This will then loop through each of the devices the user has under them and send the sync command.
            foreach ($device in $DeviceInfo) { 
                $ManagedDeviceId = $Device.Id
                Sync-MgDeviceManagementManagedDevice -ManagedDeviceId $ManagedDeviceId
                Write-Host "ID $($ManagedDeviceId) with Name $($Device.DeviceName) is syncing."
        } 
        
    }
    else {
        Write-Host `n"$($user.emailAddress) has no devices under them."
    }

}  
