#!/bin/bash

# Directorio donde se encuentra el repo bashUP
REPO_DIR="$HOME/bashUP"

# Verificar si el directorio del repositorio existe
if [ -d "$REPO_DIR" ]; then
  echo "Repositorio encontrado en $REPO_DIR."
else
  echo "No se encontró el repositorio en $REPO_DIR. Asegúrate de haberlo clonado correctamente."
  exit 1
fi

# Reemplazar ~/.bashrc con el bashrc del repositorio
echo "Reemplazando ~/.bashrc con el bashrc del repositorio..."
cp "$REPO_DIR/bashrc" ~/.bashrc

# Otorgar permisos a la carpeta myscript
echo "Otorgando permisos a la carpeta ~/myscript..."
chmod -R 755 ~/myscript

# Instalar fzf, lsd y ranger
echo "Instalando fzf, lsd y ranger..."
pkg install -y fzf lsd ranger

echo "Instalación completada. Reinicia tu terminal para aplicar los cambios."
