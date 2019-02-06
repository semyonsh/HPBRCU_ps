# HPBRCU_ps
Powershell script to run HP battery recall check from a share and append results to csv.

Details of recall: https://batteryprogram687.ext.hp.com/en-US/

## Usage

1. Make sure the HP CASL Framework is installed on target device(s), this is installed by installing the HP.BRCU.Full.Installer.exe supplied by HP. Push it with the management tool of choice. 
2. Put script on a shared folder reachable by users/machines you want to check. 
3. Use management tool of choice to push script or remotely execute script from share location. 
4. Collect the output in the "recallstatus.csv" file and import/analyse in tool of choice. 

## HP Documentation of Battery Check Utility
For managed deployment or integration into your manageability suite, HPBRP can be executed in silent mode and the results extracted and consumed into any back office reporting.  Consolidated batch ordering or processing can be implemented downstream using HPBRP by aggregating the results though this method.  HPBRP creates the log file stored in the same path the utility executes from allowing it to be scalable in deployment, supporting USB mode or remote execution.  See Appendix A for examples on remote mode execution.
### Silent Mode Instructions
HPBRP Silent Mode is accessed through the “-s” command line switch.
1)	Distribute HPBRCULauncher.exe
2)	Extract/Unzip HPBRCULauncher.exe to a folder
3)	Execute “HPBRCU.Autorun.exe –s”
4)	Access HPBRP Reporting Log for downstream reporting
### HPBRP Reporting Log
HPBRP reporting is a XML report log output into the current directory the application was executed in.  A reporting log will only be generated if the application is executed in silent mode.  Once silent mode app process is complete an XML file is generated.  The XML will be named in the format “SN_Timestamp.XML” and in the case we are unable to read or determine the SN or SN format is unknown we will record the file as “BatterRecallValidationReport_Timestamp.XML”
SN = System Serial Number
 i.e. CC#########

TimeStamp = System Time Stamp of log file in the format HHMMSS 
where:
HH = Hour
MM = Minute
SS = Second
Output xml structure:
<HPNotebookBatteryValidationUtility>
  <SystemInfo>
    <ProductName></ProductName>
    <ProductSerialNumber></ProductSerialNumber>
    <ProductNumber></ProductNumber>
    <NumBatteriesDetected></NumBatteriesDetected>
    <DateChecked></DateChecked>
    <PrimaryBatteryCTNumber></PrimaryBatteryCTNumber>
    <PrimaryBatterySerialNumber></PrimaryBatterySerialNumber>
    <PrimaryBatteryRecallStatus></PrimaryBatteryRecallStatus>
    <PrimaryBatteryReplacementUrl></PrimaryBatteryReplacementUrl>
    <PrimaryBatteryProgramEndDate></PrimaryBatteryProgramEndDate>
    <SecondaryBatteryCTNumber></SecondaryBatteryCTNumber>
    <SecondaryBatterySerialNumber></SecondaryBatterySerialNumber>
    <SecondaryBatteryRecallStatus></SecondaryBatteryRecallStatus>
    <SecondaryBatteryReplacementUrl></SecondaryBatteryReplacementUrl>
    <SecondaryBatteryProgramEndDate></SecondaryBatteryProgramEndDate>
  </SystemInfo>
</HPNotebookBatteryValidationUtility>

### Example Output XML
<HPNotebookBatteryValidationUtility>
  <SystemInfo>
    <ProductName>HP EliteBook Folio 9470m</ProductName>
    <ProductSerialNumber>CNU3209MC7</ProductSerialNumber>
    <ProductNumber>D4D58UC#ABA</ProductNumber>
    <NumBatteriesDetected>1</NumBatteriesDetected>
    <DateChecked>5/27/2016 1:01:17 PM</DateChecked>
    <PrimaryBatteryCTNumber>6CSEL08BJ4D1YT</PrimaryBatteryCTNumber>
    <PrimaryBatterySerialNumber>01548 2013/02/20</PrimaryBatterySerialNumber>
    <PrimaryBatteryRecallStatus>No recall needed</PrimaryBatteryRecallStatus>
    <PrimaryBatteryReplacementUrl>
    </PrimaryBatteryReplacementUrl>
    <PrimaryBatteryProgramEndDate>
    </PrimaryBatteryProgramEndDate>
    <SecondaryBatteryCTNumber>No Battery Detected</SecondaryBatteryCTNumber>
    <SecondaryBatterySerialNumber>Not Detected</SecondaryBatterySerialNumber>
    <SecondaryBatteryRecallStatus>Unknown or Invalid</SecondaryBatteryRecallStatus>
    <SecondaryBatteryReplacementUrl>
    </SecondaryBatteryReplacementUrl>
    <SecondaryBatteryProgramEndDate>
    </SecondaryBatteryProgramEndDate>
  </SystemInfo>
</HPNotebookBatteryValidationUtility>

### Execute remotely

HPBRP can be executed remotely over mapped network drive.  For example in batch mode:
net use  [drive letter] \\NetworkPath\Folder /user:Login Password
cd\[drive letter]
HPBRCU.Autorun.exe –s
