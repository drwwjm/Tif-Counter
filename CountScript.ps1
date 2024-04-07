# Load System.Drawing Assembly
Add-Type -AssemblyName System.Drawing

# Set the directory path of the location/folder
$directory = "G:"
# Set the directory path for the txt file output
$outputFile = "G:\count.txt"

# Get all TIFF files in the directory
$tiffFiles = Get-ChildItem -Path $directory -Filter *.tif* -File

# Initialize total image count
$totalImageCount = 0

# Initialize hashtable to store counts for each file
$counts = @{}

# Loop through each TIFF file and count images
foreach ($file in $tiffFiles) {
    $image = [System.Drawing.Image]::FromFile($file.FullName)
    $imageCount = $image.GetFrameCount([System.Drawing.Imaging.FrameDimension]::Page)
    $counts[$file.Name] = $imageCount
    $totalImageCount += $imageCount
    $image.Dispose()
}

# Write counts to a notepad file
Set-Content -Path $outputFile -Value "File Name    :    Image Count`n "
foreach ($key in $counts.Keys) {
    Add-Content -Path $outputFile -Value "$key : $($counts[$key])"
}

# Write total count 
Add-Content -Path $outputFile -Value "`nTotal Images in TIFF Files: $totalImageCount"


