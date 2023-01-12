
$path = "C:\Users\choro\Pictures\Screenshots"
$newname = "Terraform review and terminology" 
$partnumber = "02"
$destination = "C:\Users\choro\Documents\work\Epam\Лаборатория\03_Azure Terraform\Course2\"
$newdir = "00_Introduction"

.\Workbook.ps1 -Path $path `
    -NewName $newname `
    -PartNumber $partnumber `
    -Destination $destination `
    -NewDir $newdir `
    -IaAdd `
    -IaAddTranscript
