#!/bin/bash

echo "Actualizando los paquetes..."
pkg update -y && pkg upgrade -y

echo "Limpiando paquetes innecesarios..."
pkg autoclean && pkg autoremove -y

echo "Sistema actualizado y limpio."
