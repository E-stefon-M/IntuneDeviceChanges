#SEARCHING FOR THE EMAIL THEN Syncing Each device associated with the emailaddress of user. 

#https://graph.microsoft.com/beta/deviceManagement/managedDevices?$filter=emailAddress eq 'estefon.marrero@libertyutilities.com'
    #Assisted me on filtering for certain emails from MG Graph.

#Created By: Estefon Marrero
#Date Created: 3/7/2023

$emailAddresses = Import-Csv C:\temp\TestCSV\EmailAddress.csv
#Will loop through every email in the CSV file
ForEach ($user in $emailAddresses) {
    #Get Device info based off email address
    $DeviceInfo = Get-MgDeviceManagementManagedDevice -Filter "emailAddress eq '$($user.emailAddress)'"    
    
    if ($DeviceInfo){ #If the user has devices it will show the results below.

        Write-Host "Found Devices for $($user.emailAddress)." `n 

            foreach ($device in $DeviceInfo) { #This will then loop through each of the devices the user has under them and send the sync command.
                $ManagedDeviceId = $Device.Id
                Sync-MgDeviceManagementManagedDevice -ManagedDeviceId $ManagedDeviceId
                Write-Host "ID $($ManagedDeviceId) with Name $($Device.DeviceName) is syncing."
        } 
        
    }
    else {
        Write-Host `n"$($user.emailAddress) has no devices under them."
    }

}  

