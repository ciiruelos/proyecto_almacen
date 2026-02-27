#!/bin/bash

echo "===== BUSCAR POR DESCRIPCIÓN ====="
read -p "Introduce texto a buscar: " filtro

python3 buscar_descripcion.py "$filtro"

# Si no hay coincidencias
if [ ! -s nombres_busqueda.txt ]; then
    echo "No se encontraron coincidencias."
    read -n 1 -s -r -p "Pulsa una tecla para volver al menú..."
    echo
    exit 0
fi

echo
echo "Productos encontrados:"
cat nombres_busqueda.txt
echo

read -p "Selecciona un número: " opcion

# Bash controla selección válida
if ! [[ "$opcion" =~ ^[0-9]+$ ]]; then
    echo "Selección no válida."
    exit 1
fi

ruta=$(sed -n "${opcion}p" rutas_busqueda.txt)

if [ -z "$ruta" ]; then
    echo "Selección fuera de rango."
    exit 1
fi

echo
echo "Contenido del producto:"
cat "$ruta"
echo
echo "1. Editar"
echo "2. Eliminar"
echo "3. Volver"

read -p "Selecciona una opción: " accion

case $accion in
    1)
        # Reutiliza lógica anterior
        python3 editar_producto.py "$ruta"
        ;;
    2)
        echo "¿Realmente deseas eliminar este producto? [S/N]"
        read confirmacion
        if [[ "$confirmacion" == "S" || "$confirmacion" == "s" ]]; then
            rm "$ruta"
            echo "Producto eliminado con éxito."
        else
            echo "Operación cancelada."
        fi
        ;;
    3)
        echo "Volviendo al menú..."
        ;;
    *)
        echo "Opción no válida."
        ;;
esac

read -n 1 -s -r -p "Pulsa una tecla para volver al menú..."
echo
