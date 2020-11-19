function IsAuroraInstalled?ReturnWhere {
    [CmdletBinding()]
    $app = Get-ItemProperty -Path "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*" |
                Where-Object { $_.URLInfoAbout -match "http://www.project-aurora.com/" } |
                Select-Object "Inno Setup: App Path"
    if ($app) {
        return $app."Inno Setup: App Path"
        }
    }



$installPath = $(IsAuroraInstalled?ReturnWhere)
if($installPath) {
  Get-ChildItem -Path "kb_layouts/Extra Features" | % {
  Copy-Item $_.fullname "$installPath/kb_layouts/Extra Features" -Recurse -Force
  }
  do
  {
     echo "select your claymore keyboard configuration:
     1) Asus Claymore Core
     2) Asus Claymore Core + Asus Claymore Bond
     3) Asus Claymore Bond + Asus Claymore Core
     "
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                Copy-Item "kb_layouts/asus-claymore-core.json" $installPath/kb_layouts/generic_laptop.json
                echo "Asus Claymore Core keyboard layout successfully overwrite Generic Laptop"
                return
           } '2' {
                Copy-Item "kb_layouts/asus-claymore-full.json" $installPath/kb_layouts/generic_laptop.json
                echo "Asus Claymore Core + Asus Claymore Bond keyboard layout successfully overwrite Generic Laptop"
                return
           } '3' {
                Copy-Item "kb_layouts/asus-claymore-left.json" $installPath/kb_layouts/generic_laptop.json
                echo "Asus Claymore Bond + Asus Claymore Core keyboard layout successfully overwrite Generic Laptop"
                return
           } 'q' {
                return

           }
     }
     }
  until ($input -eq 'q')
} else {
echo "Please install Aurora first, you can get it at the following link:
https://www.project-aurora.com/
or with the chocolatey command:
cinst project-aurora"
}
