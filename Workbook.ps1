[CmdletBinding()]
param (
    # path to a folder
    [Parameter(mandatory = $true)]        
    [string]$Path,

    # new name
    [Parameter(mandatory = $true)]        
    [string]$NewName,

    # new name
    [Parameter(mandatory = $true)]        
    [string]$PartNumber,

    # a path for copying 
    [Parameter(mandatory = $true)]        
    [string]$Destination,

    # new name
    [Parameter(mandatory = $true)]        
    [string]$NewDir,

    # the flag for addition contents to the exist folder
    [switch]$IaAdd = $false,

    # the flag for addition contents to the exist folder
    [switch]$IaAddTranscript = $false
)
    
begin {
            
}
    
process {    
    $new_dir = $Destination + "" + $NewDir
    if (Test-Path -Path $new_dir) {
        if ($IaAdd -eq $false) {
            Write-Error "Path exists! : $NewDir"   
            return     
        }
    } 
    else { 
        New-Item -Path $new_dir -ItemType Directory 
    }
    

    [int]$number = 1;
    [string]$str_number = ""
    [string]$new_name
    Write-Host "Params:" -ForegroundColor Green 
    Write-Host "The path of screenshots: '$Path'" -ForegroundColor Green      
    
    # renaming files
    Get-ChildItem -Path $Path -File | Sort-Object -Property LastWriteTime | ForEach-Object {
        if ($number -lt 10) {
            $str_number = $PartNumber + "00" + $number
        }
        elseif ($number -lt 100) {
            $str_number = $PartNumber + "0" + $number
        }
        else {
            $str_number = $PartNumber + "" + $number
        }
        $current_file = Get-Item $_
        $new_name = $str_number + "_" + $NewName + $current_file.Extension
        Write-Host "file -> $new_name"
        Rename-Item -Path $_ -NewName $new_name              
        $number++
    }  
    # checking files
    if (Test-Path -Path "$new_dir\*$NewName*") {
        Write-Error "The files with have name '$NewName' exists!"   
        return     
    }
    if (Test-Path -Path "$new_dir\$PartNumber*") {
        Write-Error "The files which start with number '$PartNumber' existing!"   
        return     
    }

    # copying transcript
    if ($IaAddTranscript) {
        $newTranscript = "$new_dir\$PartNumber-$NewName.txt"
        Write-Host "Copy transcript to '$newTranscript'." -ForegroundColor Green
        Copy-Item ".\transcript.txt" -Destination "$newTranscript"
        Write-Host "Clear transcript." -ForegroundColor Yellow
        Clear-Content ".\transcript.txt"
    }

    # copying files
    Write-Host "Copy files to '$new_dir'." -ForegroundColor Green
    Get-ChildItem -Path $Path -File | Copy-Item -Destination $new_dir 

    # deleting screenshots
    Get-ChildItem -Path $Path -File | Remove-Item
    Write-Host "The folder 'screenshots' was cleared." -ForegroundColor Yellow  
}
    
end {
}