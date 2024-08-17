#!/data/data/com.termux/files/usr/bin/bash

# Obtener la fecha y hora actual
datetime=$(date +"%Y-%m-%d %H:%M:%S")

# Mostrar la barra con un fondo amarillo claro
echo -e "\e[43m\e[30m Hora: $datetime \e[0m"

