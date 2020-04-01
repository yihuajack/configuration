Import-Module DirColors
Update-DirColors ~/dircolors.256dark
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme PowerLine
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
# Invoke-Expression (&starship init powershell)
Import-Module posh-sshell