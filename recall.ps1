<#
Script to run the HP battery check from a share and append results to a csv. 

Dependencies:
- HP CASL framework, make sure the HPBRCU utility is installed (Pushed by management tool of choice or PS script.)

If it's not installed it will throw an (non-descriptive) error.
#>

#Sources and destinations
$hpRoot = "C:\hpbrcu"
$hpbrcu = "\\share\location\of\choice"
$csvDestination = "\\share\location\of\choice"

$reachShare = $true

function checkPath {

    #Check if share is reachable
    if (Test-Path $hpbrcu) {
        Write-Host 'Path reachable'
        }
    else {
        $global:reachShare = $false
        }
}


function checkBattery {
    
    #Create a folder for the xml file, ignore error if it already exists
    New-Item -ErrorAction Ignore -ItemType directory -Path $hpRoot

    #Run the HP Battery Check silently and output xml to folder of choice
    $runHPBRCU = Join-Path -Path $hpbrcu -ChildPath HPBRCU.exe
    & $runHPBRCU -s -p:$hpRoot

    #Sleep timer to let the check finish 
    Start-Sleep -s 20

}


function writeCsv {

    #Import XML path and file
    $xmlFile = Get-ChildItem -Path $hpRoot -Filter *.xml | Select-Object -ExpandProperty FullName

    [xml]$xmlDocument = Get-Content -Path $xmlFile 

    #Destination of csv file
    $csvFile = Join-Path -Path $csvDestination -ChildPath recallstatus.csv
    
    #Create an object, get values out of the xml file and append to csv file
    New-Object -TypeName PSCustomObject -Property @{
    Hostname = hostname
    ProductSerialNumber = $xmlDocument.SelectNodes('//ProductSerialNumber') | Select-Object -Expand '#text'
    ProductNumber = $xmlDocument.SelectNodes('//ProductNumber') | Select-Object -Expand '#text'
    Date = $date = $xmlDocument.SelectNodes('//DateChecked') | Select-Object -Expand '#text'
    PrimaryBatteryCTNumber = $xmlDocument.SelectNodes('//PrimaryBatteryCTNumber') | Select-Object -Expand '#text'
    PrimaryBatteryRecallStatus = $xmlDocument.SelectNodes('//PrimaryBatteryRecallStatus') | Select-Object -Expand '#text'
    } | Export-Csv -Path $csvFile -NoTypeInformation -Append

}

checkPath

if ($reachShare){

    checkBattery

    writeCsv

    #Delete folder after use, ignore error if it doesn't exist
    Remove-Item $hpRoot -Recurse -ErrorAction Ignore
}
else {

    exit

}
