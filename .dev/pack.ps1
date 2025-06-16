# Deploy script
# Parte do arquivo de outros projetos meus, parte do Github Copilot já que não é parte do trabalho em si.

$zipFileName = "AVA2-Desenvolvimento-de-Aplicações-Distribuídas-e-WEB-II_Adriano_Cahete.zip"

$repoRoot = Split-Path -Parent (Split-Path -Parent $PSCommandPath)

$gitIgnorePath = Join-Path $repoRoot ".gitignore"
$excludePatterns = @()

if (Test-Path $gitIgnorePath) {
  $gitIgnoreContent = Get-Content -Path $gitIgnorePath
  foreach ($line in $gitIgnoreContent) {
    $line = $line.Trim()
    # Skip empty lines and comments
    if ($line -and -not $line.StartsWith('#')) {
      # Convert .gitignore pattern to PowerShell wildcard pattern
      $pattern = $line -replace '^\/', '' -replace '\*\*', '*' -replace '\.', '\.'
      $pattern = "*/$pattern*"
      $excludePatterns += $pattern
    }
  }
}

$excludePatterns += @(
  "*/.git/*",
  "*.zip"
)

Write-Host "Loaded $(($excludePatterns | Measure-Object).Count) exclusion patterns from .gitignore"

$tempDir = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString())
New-Item -Path $tempDir -ItemType Directory -Force | Out-Null

Write-Host "Copying files to temporary directory..."
Get-ChildItem -Path $repoRoot -Recurse -File | ForEach-Object {
  $relativePath = $_.FullName.Substring($repoRoot.Length + 1)

  $exclude = $false
  foreach ($pattern in $excludePatterns) {
    if ($relativePath -like $pattern) {
      $exclude = $true
      break
    }
  }

  if (-not $exclude) {
    $targetPath = Join-Path $tempDir $relativePath
    $targetDir = Split-Path -Parent $targetPath

    if (-not (Test-Path $targetDir)) {
      New-Item -Path $targetDir -ItemType Directory -Force | Out-Null
    }

    Copy-Item -Path $_.FullName -Destination $targetPath -Force
  }
}

# Create the zip file
Write-Host "Creating zip file: $zipFileName..."
Compress-Archive -Path "$tempDir\*" -DestinationPath (Join-Path $repoRoot $zipFileName) -Force

# Clean up the temporary directory
Write-Host "Cleaning up temporary files..."
Remove-Item -Path $tempDir -Recurse -Force

Write-Host "Package created successfully: $zipFileName"
