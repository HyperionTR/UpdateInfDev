# --- CONFIGURACIÓN ---
$InstanceDir = "C:\path\to\your\UltimMC\instances\InfdevPlus-Latest-MultiMC"
$ModDir = "$InstanceDir\jarmods"
$BackupRoot = "$InstanceDir\jar_backups"
$OgBackupDir = "$InstanceDir\og_jar_backup"
$BackupCount = 5
$JarName = "InfdevPlus-Client.jar"
$DownloadUrl = "https://drive.google.com/uc?export=download&id=1JRmzcxxDojXMr52W9u5uBfi1pwN80s6O"

# --- VALIDACIÓN ---
if (!(Test-Path $ModDir)) { Write-Error "Directorio no encontrado."; exit }

# --- RESPALDO INICIAL (OG) ---
if (!(Test-Path $OgBackupDir)) {
    New-Item -ItemType Directory -Path $OgBackupDir
    Copy-Item "$ModDir\$JarName" "$OgBackupDir\$JarName"
    Write-Host "Versión original respaldada."
}

# --- DESCARGA ---
$TempDir = Join-Path $env:TEMP ([Guid]::NewGuid().ToString())
New-Item -ItemType Directory -Path $TempDir | Out-Null

try {
    Write-Host "Descargando..."
    Invoke-WebRequest -Uri $DownloadUrl -OutFile "$TempDir\$JarName"

    # --- ÉXITO: RESPALDO Y ACTUALIZACIÓN ---
    $Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $CurrentBackup = New-Item -ItemType Directory -Path "$BackupRoot\backup_$Timestamp" -Force
    
    Copy-Item "$ModDir\$JarName" "$CurrentBackup\$JarName"
    Move-Item "$TempDir\$JarName" "$ModDir\$JarName" -Force
    Write-Host "Actualizado con éxito."

    # --- ROTACIÓN ---
    $OldBackups = Get-ChildItem $BackupRoot | Sort-Object LastWriteTime
    if ($OldBackups.Count -gt $BackupCount) {
        $OldBackups | Select-Object -First ($OldBackups.Count - $BackupCount) | Remove-Item -Recurse -Force
    }
} catch {
    Write-Error "Fallo en la descarga. Sin cambios."
} finally {
    Remove-Item $TempDir -Recurse -Force
}
