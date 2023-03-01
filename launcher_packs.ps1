$path = "The path to screenshots"
$destination = "The path to draft"
$newdir = "The name of a new folder"

.\Workbook.ps1 -Path $path -PartNumber "000" -First 2 -NewName "New Name" -Destination $destination -NewDir $newdir -IaAdd
