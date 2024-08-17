#!/bin/bash

# Función para listar los paquetes instalados y su tamaño en MB
function listar_paquetes() {
  echo "Listando paquetes instalados..."

  # Obtiene la lista de paquetes y su tamaño, y lo convierte a MB
  pkg_list=$(dpkg-query -W -f='${Installed-Size}\t${Package}\n' | \
    awk '{printf "%.2fMB\t%s\n", $1/1024, $2}' | sort -n)

  # Usa fzf para seleccionar un paquete
  selected_pkg=$(echo "$pkg_list" | fzf --prompt="Selecciona un paquete para gestionar: ")

  if [[ -z "$selected_pkg" ]]; then
    echo "No se seleccionó ningún paquete."
    exit 1
  fi

  pkg_name=$(echo "$selected_pkg" | awk '{print $2}')
  pkg_size=$(echo "$selected_pkg" | awk '{print $1}')

  echo "Paquete seleccionado: $pkg_name"
  echo "Tamaño: $pkg_size"
  
  # Preguntar si desea desinstalar el paquete
  read -p "¿Quieres desinstalar $pkg_name? (s/n): " confirm
  if [[ "$confirm" == "s" ]]; then
    pkg uninstall "$pkg_name"
    echo "$pkg_name desinstalado."
  else
    echo "Operación cancelada."
  fi
}

# Verifica si fzf está instalado
if ! command -v fzf &> /dev/null
then
    echo "fzf no está instalado. Instalando..."
    pkg install fzf -y
fi

listar_paquetes
