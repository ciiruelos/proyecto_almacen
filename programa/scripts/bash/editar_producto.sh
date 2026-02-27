#!/bin/bash

ruta="$1"

if [ ! -f "$ruta" ]; then
    echo "Error: El archivo no existe."
    exit 1
fi

echo "HAS PULSADO EDITAR PRODUCTO"
echo "Pulsa ENTER para mantener el valor actual"
echo

# Obtener valores actuales desde el JSON
nombre=$(python3 -c "import json; print(json.load(open('$ruta'))['nombre'])")
descripcion=$(python3 -c "import json; print(json.load(open('$ruta'))['descripcion'])")
precio=$(python3 -c "import json; print(json.load(open('$ruta'))['precio'])")
stock=$(python3 -c "import json; print(json.load(open('$ruta'))['stock'])")


# Mostrar y pedir nuevos valores
echo "Nombre actual: $nombre"
read -p "Nuevo nombre: " nuevo_nombre
[ -z "$nuevo_nombre" ] && nuevo_nombre="$nombre"

echo
echo "Descripción actual: $descripcion"
read -p "Nueva descripción: " nueva_descripcion
[ -z "$nueva_descripcion" ] && nueva_descripcion="$descripcion"

echo
echo "Precio actual: $precio"
read -p "Nuevo precio: " nuevo_precio
[ -z "$nuevo_precio" ] && nuevo_precio="$precio"

echo
echo "Stock actual: $stock"
read -p "Nuevo stock: " nuevo_stock
[ -z "$nuevo_stock" ] && nuevo_stock="$stock"


echo
read -p "¿Confirmar cambios? (S/N): " confirmar

if [[ "$confirmar" == "S" || "$confirmar" == "s" ]]; then
    python3 - <<EOF
import json

ruta = "$ruta"

producto = {
    "nombre": "$nuevo_nombre",
    "descripcion": "$nueva_descripcion",
    "precio": $nuevo_precio,
    "stock": $nuevo_stock,
    
}

with open(ruta, "w", encoding="utf-8") as archivo:
    json.dump(producto, archivo, indent=4, ensure_ascii=False)

print("Producto actualizado correctamente.")
EOF
else
    echo "Edición cancelada."
fi

read -n 1 -s -r -p "Pulsa una tecla para volver al menú..."
echo
