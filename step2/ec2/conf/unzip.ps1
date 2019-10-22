Param (
    [Parameter(Mandatory = $true)]
    [String] $ZipFilePath = [String]::Empty,
    [Parameter(Mandatory = $true)]
    [String] $OutPath = [String]::Empty
)

Add-Type -AssemblyName System.IO.Compression.FileSystem

function Unzip {
    param([string]$zipfile, [string]$outpath)

    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
}

Unzip $ZipFilePath $OutPath