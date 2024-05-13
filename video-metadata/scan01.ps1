# Path to the directory containing the video files
$videoDirectory = "X:\Media\Videos\"

# Check if MediaInfo is installed
$mediaInfoPath = "C:\Tools\media-info-cli\MediaInfo.exe"
if (-Not (Test-Path $mediaInfoPath)) {
    Write-Error "MediaInfo is not installed. Please install it from https://mediaarea.net/en/MediaInfo/Download"
    exit
}

# Get all video files in the directory including subdirectories for common video formats
$videoFiles = Get-ChildItem -Include *.mp4, *.mkv  -Path "$videoDirectory" -Recurse

# Check if there are any video files found
if ($videoFiles.Count -eq 0) {
    Write-Host "No video files found in the directory $videoDirectory"
    exit
}

# Initialize an array to hold the data for export
$results = @()

# Loop through each video file and extract information
foreach ($file in $videoFiles) {
    $filePath = $file.FullName
    $fileRelativePath = $file.FullName.Replace($videoDirectory, '')
    $fileExtension = $file.Extension
    $fileSizeMB = [math]::Round($file.Length / 1MB, 2)

    # Retrieve video and audio codec information using MediaInfo
    try {

        $videoCodec = & $mediaInfoPath "--Inform=Video;%CodecID%" "$filePath"
        $audioCodec = & $mediaInfoPath "--Inform=Audio;%CodecID%" "$filePath"

        # Create a custom object to hold the data for this file
        $result = [PSCustomObject]@{
            'Full Path'     = $filePath
            'Relative Path' = $fileRelativePath
            'Extension'     = $fileExtension
            'Video Codec'   = $videoCodec
            'Audio Codec'   = $audioCodec
            'Size (MB)'     = $fileSizeMB
        }
        $results += $result
        Write-Host $result
    } catch {
        Write-Warning "Failed to get codec information for file: $filePath"
    }
}

# Export the results to a CSV file
$results | Export-Csv -Path "$videoDirectory\VideoCodecSummary.csv" -Delimiter ";" -NoTypeInformation
Write-Host "Exported codec information to '$videoDirectory\VideoCodecSummary.csv'"
