#!/bin/bash

# --- CONFIGURACIÓN ---
INSTANCE_DIR="/home/einhander/Juegos/UltimMC/instances/InfdevPlus-Latest-MultiMC"
MOD_DIR="$INSTANCE_DIR/jarmods"
BACKUP_ROOT="$INSTANCE_DIR/jar_backups"
OG_JAR_BACKUP_DIR="$INSTANCE_DIR/og_jar_backup"
BACKUP_COUNT=5
JAR_NAME="InfdevPlus-Client.jar"
DOWNLOAD_URL="https://drive.google.com/uc?export=download&id=1JRmzcxxDojXMr52W9u5uBfi1pwN80s6O"

# --- VALIDACIÓN DE ENTORNO ---
if [ ! -d "$MOD_DIR" ]; then
    echo "ERROR: Directorio del mod no encontrado en $MOD_DIR"
    exit 1
fi

# --- Respaldo de la primer versión del mod en esta instancia
if [ ! -d "$OG_JAR_BACKUP_DIR" ]; then
	echo "Creando respaldo de la versión original del mod en esta instancia"
	mkdir "$OG_JAR_BACKUP_DIR"
	cp "$MOD_DIR/$JAR_NAME" "$OG_JAR_BACKUP_DIR/$JAR_NAME"
	echo "Versión original respaldada"
fi

mkdir -p "$BACKUP_ROOT"
TEMP_DIR=$(mktemp -d)

# --- 1. INTENTO DE DESCARGA ---
echo "Iniciando descarga de la última versión..."
if wget -q --show-progress "$DOWNLOAD_URL" -O "$TEMP_DIR/$JAR_NAME"; then
    
    # --- 2. ÉXITO: PROCEDER CON RESPALDO Y ACTUALIZACIÓN ---
    TIMESTAMP=$(date +'%Y%m%d_%H%M%S')
    CURRENT_BACKUP_DIR="$BACKUP_ROOT/backup_$TIMESTAMP"

    # Crear backup del archivo viejo antes de sobreescribirlo
    if [ -f "$MOD_DIR/$JAR_NAME" ]; then
        echo "Creando backup de la versión anterior..."
        mkdir -p "$CURRENT_BACKUP_DIR"
        cp "$MOD_DIR/$JAR_NAME" "$CURRENT_BACKUP_DIR/$JAR_NAME"
    fi

    # Reemplazar por la nueva versión
    mv "$TEMP_DIR/$JAR_NAME" "$MOD_DIR/$JAR_NAME"
    echo "Actualización instalada correctamente."

    # --- 3. ROTACIÓN DE BACKUPS (Solo ocurre si todo lo anterior salió bien) ---
    echo "Limpiando backups antiguos (Límite: $BACKUP_COUNT)..."
    ls -1dt "$BACKUP_ROOT"/backup_*/ 2>/dev/null | tail -n +"$((BACKUP_COUNT + 1))" | xargs -d '\n' rm -rf

else
    # --- 4. FALLO: LIMPIEZA SILENCIOSA ---
    echo "ERROR: La descarga falló. No se realizaron cambios ni backups."
    rm -rf "$TEMP_DIR"
    exit 1
fi

# Limpieza final de temporales
rm -rf "$TEMP_DIR"
