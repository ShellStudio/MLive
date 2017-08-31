function Build-MLivePackage {
    [CmdletBinding()]
    param (
        [System.IO.DirectoryInfo]
        $Path = "."
    )
    Process {
        $Path = Get-Item $Path
        Push-Location -Path $Path
        bash /usr/bin/makepkg-mingw
        Pop-Location
    }
}
Set-Alias mbuild Build-MLivePackage
