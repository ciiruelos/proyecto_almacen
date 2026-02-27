#!/bin/bash

DESTINO="$1"
clear

# Comprobar que se ha recibido un directorio destino
if [ -z "$DESTINO" ]; then
  echo "No se ha recibido directorio" > /dev/tty
  exit 1
fi

# Pedir nombre usando el terminal real
echo -n "Introduce el nombre de la nueva marca: " > /dev/tty
read NOMBRE < /dev/tty

# Validación mínima
if [ -z "$NOMBRE" ]; then
  echo "Nombre no válido" > /dev/tty
  exit 1
fi

NUEVO_DIR="$DESTINO/$NOMBRE"

# Comprobar si ya existe
if [ -d "$NUEVO_DIR" ]; then
  echo "El directorio ya existe: $NUEVO_DIR" > /dev/tty
  exit 1
fi

# Crear el directorio
mkdir -p "$NUEVO_DIR"

echo "Directorio '$NOMBRE' creado en $DESTINO" > /dev/tty

