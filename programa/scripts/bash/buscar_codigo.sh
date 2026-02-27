#!/bin/bash
clear
TIENDA="/tiendas/tiendaDam"

read -p "Indica el código del producto: " codigo

# Comprobar código vacío
if [[ -z "$codigo" ]]; then
    read -n1 -p "El código no puede estar vacío. Pulsa una tecla..."
    exit
fi

# Buscar el archivo en todos los subdirectorios
ruta=$(find "$TIENDA" -type f -name "$codigo.json" 2>/dev/null)

# Si no se encuentra
if [[ "$ruta" == "" ]]; then
    echo "No se ha encontrado ninguna coincidencia."
    read -n1 -p "Pulsa una tecla para volver o intentarlo de nuevo..."
    exit
fi

# Mostrar información del producto
nombre=$(jq -r '.nombre' "$ruta")
descripcion=$(jq -r '.descripcion' "$ruta")
precio=$(jq -r '.precio' "$ruta")
stock=$(jq -r '.stock' "$ruta")

echo "----------------------------"
echo "Nombre:      $nombre"
echo "Descripción: $descripcion"
echo "Precio:      $precio"
echo "Stock:       $stock"
echo "----------------------------"

# Menú
read -p "¿Qué desea hacer? Editar (e), Borrar (b), Volver (v): " opcion

case "$opcion" in
    e|E)
        bash /home/alumno/programa/scripts/bash/editar_producto.sh "$ruta"
        ;;
    b|B)
        read -p "¿Realmente deseas eliminar este producto? [S/N]: " confirmar
        if [[ "$confirmar" == "S" || "$confirmar" == "s" ]]; then
            rm "$ruta"
            echo "Producto eliminado con éxito."
        else
            echo "Operación cancelada."
        fi
        read -n1 -p "Pulsa una tecla para volver al menú..."
        ;;
    v|V)
        exit
        ;;
    *)
        read -n1 -p "Opción no válida. Pulsa una tecla..."
        ;;
esac
