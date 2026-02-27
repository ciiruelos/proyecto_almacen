#!/bin/bash

codigo="$1"
ruta="productos/$codigo.json"

# Verificar existencia
if [ ! -f "$ruta" ]; then
    echo "Error: El producto con código $codigo no existe."
    read -n 1 -s -r -p "Pulsa una tecla para volver al menú..."
    echo
    exit 1
fi

echo "¿Realmente deseas eliminar este producto? [S/N]"
read confirmacion

if [[ "$confirmacion" == "S" || "$confirmacion" == "s" ]]; then
    rm "$ruta"
    echo "Producto eliminado con éxito."
else
    echo "Operación cancelada."
fi

read -n 1 -s -r -p "Pulsa una tecla para volver al menú..."
echo
