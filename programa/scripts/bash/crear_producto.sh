#!/bin/bash

# Ruta raíz de la tienda
TIENDA="/tiendas/tiendaDam"

# Ruta de la marca pasada como argumento
DESTINO="$1"

# Comprobar que se recibe un directorio
if [ -z "$DESTINO" ]; then
    echo "No se ha recibido directorio" > /dev/tty
    exit 1
fi

if [ ! -d "$DESTINO" ]; then
    echo "El directorio $DESTINO no existe" > /dev/tty
    exit 1
fi

# Pedir nombre del producto
echo -n "Introduce el nombre del producto: " > /dev/tty
read NOMBRE < /dev/tty

if [ -z "$NOMBRE" ]; then
    echo "Nombre no válido" > /dev/tty
    exit 1
fi

# Reemplazar espacios por _
NOMBRE=$(echo "$NOMBRE" | tr ' ' '_')

# Comprobar si el producto ya existe en TODA la tienda
EXISTE=$(find "$TIENDA" -type f -name "$NOMBRE.json" 2>/dev/null)

if [ -n "$EXISTE" ]; then
    echo "Ya existe un producto con ese nombre en la tienda." > /dev/tty
    echo "Ubicación: $EXISTE" > /dev/tty
    exit 1
fi

# Crear archivo JSON en la ruta de la marca
ARCHIVO="$DESTINO/$NOMBRE.json"

cat <<EOF > "$ARCHIVO"
{
    "nombre": "",
    "descripcion": "",
    "precio": "",
    "stock": "",
    "envase": ""
}
EOF

chmod 664 "$ARCHIVO"

echo "JSON creado en $ARCHIVO" > /dev/tty

