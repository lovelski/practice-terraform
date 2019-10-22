Param (
    [Parameter(Mandatory = $true)]
    [String] $filePath = [String]::Empty,
    [Parameter(Mandatory = $true)]
    [String] $FindText = [String]::Empty,
    [Parameter(Mandatory = $true)]
    [String] $ReplaceText = [String]::Empty
)

(Get-Content -path $filePath -Raw) -replace $FindText, $ReplaceText