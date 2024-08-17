#!/bin/bash

# Función para mostrar el menú de la calculadora
show_menu() {
    clear
    echo "-----------------------------"
    echo "   Calculadora Científica"
    echo "-----------------------------"
    echo "1) Suma"
    echo "2) Resta"
    echo "3) Multiplicación"
    echo "4) División"
    echo "5) Seno"
    echo "6) Coseno"
    echo "7) Logaritmo"
    echo "8) Salir"
    echo "-----------------------------"
    echo -n "Elige una opción: "
}

# Función para realizar cálculos
calculate() {
    case $1 in
        1) # Suma
            echo "Introduce el primer número: "
            read a
            echo "Introduce el segundo número: "
            read b
            echo "Resultado: $(echo "$a + $b" | bc)"
            ;;
        2) # Resta
            echo "Introduce el primer número: "
            read a
            echo "Introduce el segundo número: "
            read b
            echo "Resultado: $(echo "$a - $b" | bc)"
            ;;
        3) # Multiplicación
            echo "Introduce el primer número: "
            read a
            echo "Introduce el segundo número: "
            read b
            echo "Resultado: $(echo "$a * $b" | bc)"
            ;;
        4) # División
            echo "Introduce el primer número: "
            read a
            echo "Introduce el segundo número: "
            read b
            echo "Resultado: $(echo "scale=4; $a / $b" | bc)"
            ;;
        5) # Seno
            echo "Introduce el ángulo en grados: "
            read angle
            radians=$(echo "$angle * 4 * a(1) / 180" | bc -l)
            echo "Resultado: $(echo "s($radians)" | bc -l)"
            ;;
        6) # Coseno
            echo "Introduce el ángulo en grados: "
            read angle
            radians=$(echo "$angle * 4 * a(1) / 180" | bc -l)
            echo "Resultado: $(echo "c($radians)" | bc -l)"
            ;;
        7) # Logaritmo
            echo "Introduce el número: "
            read num
            echo "Resultado: $(echo "l($num)" | bc -l)"
            ;;
        8) # Salir
            exit 0
            ;;
        *) # Opción inválida
            echo "Opción no válida."
            ;;
    esac
}

# Bucle principal
while true; do
    show_menu
    read choice
    calculate $choice
    echo "Presiona Enter para continuar..."
    read
done
