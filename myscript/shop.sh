#!/bin/bash

# Verifica si el paquete 'apt' está instalado
if ! command -v apt &> /dev/null; then
  echo "El comando 'apt' no está disponible. Asegúrate de estar en Termux."
  exit 1
fi

# Actualiza la lista de paquetes
echo "Actualizando lista de paquetes..."
apt update -y

# Obtiene los 10 paquetes más populares (los primeros en la lista de apt-cache search)
echo "Los 10 paquetes más populares:"
apt-cache search . | head -n 10 | while read -r line; do
  pkg=$(echo "$line" | awk '{print $1}')
  desc=$(apt-cache show "$pkg" 2>/dev/null | grep -m 1 "Description:" | sed 's/^Description: //')
  echo "Paquete: $pkg"
  echo "Descripción: $desc"
  echo "-----------------------------"
done

echo ""

# Búsqueda de otros paquetes
read -p "Introduce un término para buscar paquetes: " search_term

if [ -z "$search_term" ]; then
  echo "No se ha introducido ningún término de búsqueda."
  exit 1
fi

echo "Resultados de búsqueda para '$search_term':"
apt-cache search "$search_term" | while read -r line; do
  pkg=$(echo "$line" | awk '{print $1}')
  desc=$(apt-cache show "$pkg" 2>/dev/null | grep -m 1 "Description:" | sed 's/^Description: //')
  echo "Paquete: $pkg"
  echo "Descripción: $desc"
  echo "-----------------------------"
done
