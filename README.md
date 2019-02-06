# HPBRCU_ps
Powershell script to run HP battery recall check from a share and append results to csv.

Details of recall: https://batteryprogram687.ext.hp.com/en-US/

## Usage

1. Make sure the HP CASL Framework is installed on target device(s), this is installed by installing the HP.BRCU.Full.Installer.exe supplied by HP. Push it with the management tool of choice. 
2. Put script on a shared folder reachable by users/machines you want to check. 
3. Use management tool of choice to push script or remotely execute script from share location. 
4. Collect the output in the "recallstatus.csv" file and import/analyse in tool of choice. 

