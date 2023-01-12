
$path = "The path to screenshots"
$newname = "Name img" 
$partnumber = "00"
$destination = "The path to draft"
$newdir = "The name of a new folder"

.\Workbook.ps1 -Path $path `
    -NewName $newname `
    -PartNumber $partnumber `
    -Destination $destination `
    -NewDir $newdir `
    -IaAdd `
    -IaAddTranscript