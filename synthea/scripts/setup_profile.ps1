# Copies (or merges) this project's dbt profile into the default dbt profiles
# location (%USERPROFILE%\.dbt\profiles.yml), without overwriting profiles
# that already exist there for other dbt projects.

$dbtDir = "$env:USERPROFILE\.dbt"
$profilePath = "$dbtDir\profiles.yml"
$templatePath = Join-Path $PSScriptRoot "..\profiles.yml.example"

if (-not (Test-Path $dbtDir)) {
    New-Item -ItemType Directory -Path $dbtDir | Out-Null
}

if (Test-Path $profilePath) {
    $existing = Get-Content $profilePath -Raw
    if ($existing -match "(?m)^synthea:") {
        Write-Host "Profile 'synthea' already exists in $profilePath -- nothing changed."
    } else {
        $template = Get-Content $templatePath -Raw
        Add-Content -Path $profilePath -Value "`n$template"
        Write-Host "Profile 'synthea' appended to existing $profilePath"
    }
} else {
    Copy-Item -Path $templatePath -Destination $profilePath
    Write-Host "Created $profilePath with the 'synthea' profile."
}
