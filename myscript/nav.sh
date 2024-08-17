#!/bin/bash

function listar_directorios() {
  echo "Directorios en $(pwd):"
  dirs=(*/)
  for i in "${!dirs[@]}"; do
    echo "[$i] ${dirs[$i]}"
  done
}

function cambiar_directorio() {
  read -p "Selecciona un número de directorio: " num
  if [[ -d "${dirs[$num]}" ]]; then
    cd "${dirs[$num]}"
    listar_archivos
  else
    echo "Selección inválida"
  fi
}

function listar_archivos() {
  echo "Archivos en $(pwd):"
  ls -p | grep -v /
}

listar_directorios
cambiar_directorio
