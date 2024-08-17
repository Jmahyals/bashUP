#!/bin/bash

echo "Selecciona una acción:"
echo "[1] Actualizar paquetes"
echo "[2] Limpiar sistema"
echo "[3] Crear backup"

read -p "Opción: " opt

case $opt in
  1)
    cd /sdcard/.mint node server
    ;;
  2)
    pkg autoclean && pkg autoremove -y
    ;;
  3)
    ~/scripts/backup.sh
    ;;
  *)
    echo "Opción inválida"
    ;;
esac