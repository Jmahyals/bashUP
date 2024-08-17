#!/data/data/com.termux/files/usr/bin/bash

# Obtener la fecha y hora actual
datetime=$(date +"%Y-%m-%d %H:%M:%S")
# Obtener el tamaño del directorio actual
dir_size=$(du -sh . | awk '{print $1}')

# Mostrar la información
echo "Hora actual: $datetime"
echo "Tamaño del directorio actual: $dir_size"

