enum Arch {
    All
    i686
    x86_64
}

function Build-MLivePackage {
    [CmdletBinding()]
    param (
        [System.IO.DirectoryInfo]
        $Path = ".",
        [Arch]
        $Arch = [Arch]::All
    )
    Process {
        $Path = Get-Item $Path
        Push-Location -Path $Path
        [System.Collections.ArrayList]$mingw = @()
        if ($Arch -eq [Arch]::i686 -or $Arch -eq [Arch]::All) {
            [Void]$mingw.Add('mingw32')
        }
        if ($Arch -eq [Arch]::x86_64 -or $Arch -eq [Arch]::All) {
            [Void]$mingw.Add('mingw64')
        }
        bash -c ("MINGW_INSTALLS='" + $([String]::Join(' ', [Array]$mingw)) +
                 "' /usr/bin/makepkg-mingw -f")
        Pop-Location
    }
}
Set-Alias mpack Build-MLivePackage

function Install-MLivePackage {
[CmdletBinding()]
    param (
        [System.IO.DirectoryInfo]
        $Path = ".",
        [Arch]
        $Arch = [Arch]::All
    )
    Process {
        $Path = Get-Item $Path
        $Name = $Path.Name
        Push-Location -Path $Path
        Build-MLivePackage -Path $Path
        if ($Arch -eq [Arch]::i686 -or $Arch -eq [Arch]::All) {
            pacman -U mingw-w64-i686-$Name-*.pkg.tar.xz
        }
        if ($Arch -eq [Arch]::x86_64 -or $Arch -eq [Arch]::All) {
            pacman -U mingw-w64-x86_64-$Name-*.pkg.tar.xz
        }
        Pop-Location
    }
}
Set-Alias minst Install-MLivePackage
