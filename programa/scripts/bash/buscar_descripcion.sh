#!/bin/bash

TIENDA="/tiendas/nombre_tienda"

echo "===== BUSCAR PRODUCTO POR DESCRIPCIÓN ====="
echo
read -p "Introduce texto a buscar: " filtro

# Comprobar filtro vacío
if [[ -z "$filtro" ]]; then
    read -n1 -p "El texto no puede estar vacío. Pulsa una tecla..."
    exit
fi

# Buscar coincidencias en descripcion (sin distinguir mayúsculas)
mapfile -t resultados < <(find "$TIENDA" -type f -name "*.json" 2>/dev/null | while read archivo; do
    descripcion=$(jq -r '.descripcion' "$archivo" 2>/dev/null)
    if echo "$descripcion" | grep -iq "$filtro"; then
        echo "$archivo"
    fi
done)

# Si no hay resultados
if [[ ${#resultados[@]} -eq 0 ]]; then
    echo
    echo "No se ha encontrado ninguna coincidencia."
    read -n1 -p "Pulsa una tecla para volver..."
    exit
fi

# Mostrar lista numerada
echo
echo "Resultados encontrados:"
for i in "${!resultados[@]}"; do
    nombre=$(jq -r '.nombre' "${resultados[$i]}")
    echo "$((i+1)). $nombre"
done

echo
read -p "Selecciona un número (o v para volver): " seleccion

if [[ "$seleccion" == "v" || "$seleccion" == "V" ]]; then
    exit
fi

# Validar número
if ! [[ "$seleccion" =~ ^[0-9]+$ ]] || (( seleccion < 1 || seleccion > ${#resultados[@]} )); then
    read -n1 -p "Opción no válida. Pulsa una tecla..."
    exit
fi

ruta="${resultados[$((seleccion-1))]}"

# Mostrar información del producto
nombre=$(jq -r '.nombre' "$ruta")
descripcion=$(jq -r '.descripcion' "$ruta")
precio=$(jq -r '.precio' "$ruta")
stock=$(jq -r '.stock' "$ruta")
envase=$(jq -r '.envase' "$ruta")

echo
echo "----------------------------"
echo "Nombre:      $nombre"
echo "Descripción: $descripcion"
echo "Precio:      $precio"
echo "Stock:       $stock"
echo "Envase:      $envase"
echo "----------------------------"

# Menú de acciones
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
        read -n1 -p "Pulsa una tecla para continuar..."
        ;;
    v|V)
        exit
        ;;
    *)
        read -n1 -p "Opción no válida. Pulsa una tecla..."
        ;;
esac
