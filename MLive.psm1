enum Arch {
    All
    i686
    x86_64
}

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
Set-Alias mpack Build-MLivePackage

function Install-MLivePackage {
[CmdletBinding()]
    param (
        [System.IO.DirectoryInfo]
        $Path = "."
    )
    Process {
        $Path = Get-Item $Path
        $Name = $Path.Name
        Push-Location -Path $Path
        Build-MLivePackage -Path $Path
        pacman -U mingw-w64-i686-$Name-*.pkg.tar.xz
        pacman -U mingw-w64-x86_64-$Name-*.pkg.tar.xz
        Pop-Location
    }
}
Set-Alias minst Install-MLivePackage
