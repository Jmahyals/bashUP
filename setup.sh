#!/bin/bash

# Directorio donde se encuentra el repo bashUP
REPO_DIR="$HOME/bashUP"
MYSCRIPT_DIR="$HOME/myscript"

# Verificar si el directorio del repositorio existe
if [ -d "$REPO_DIR" ]; then
  echo "Repositorio encontrado en $REPO_DIR."
else
  echo "No se encontró el repositorio en $REPO_DIR. Asegúrate de haberlo clonado correctamente."
  exit 1
fi

# Reemplazar ~/.bashrc con el bashrc del repositorio
echo "Reemplazando ~/.bashrc con el bashrc del repositorio..."
cp -f "$REPO_DIR/bashrc" ~/.bashrc

# Verificar si la carpeta myscript existe
if [ -d "$MYSCRIPT_DIR" ]; then
  # Otorgar permisos de ejecución a todos los archivos shell en la carpeta myscript
  echo "Otorgando permisos de ejecución a los archivos shell en ~/myscript..."
  find "$MYSCRIPT_DIR" -type f -name "*.sh" -exec chmod +x {} \;
else
  echo "La carpeta ~/myscript no existe. Asegúrate de haberla creado y de que contenga tus scripts."
fi

# Instalar fzf, lsd y ranger
echo "Instalando fzf, lsd y ranger..."
pkg install -y fzf lsd ranger

echo "Instalación completada. Reinicia tu terminal para aplicar los cambios."
