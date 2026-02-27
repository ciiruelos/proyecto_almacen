#!/bin/bash
clear
echo ""

read -p "Indica el nombre de la nueva categoría: " categoria < /dev/tty

# Nombre vacío
if [ -z "$categoria" ]; then
	echo
	echo "Error: el nombre no puede estar vacío"
	echo "Pulsa una tecla para continuar"
	read -n1 < /dev/tty
	exit 1
fi

# Crear directamente en la ruta
if mkdir -p "/tiendas/tiendaDam/$categoria" 2>/dev/null; then
	echo
	echo "Categoría creada correctamente"
	echo "Pulsa una tecla para continuar"
	read -n1 < /dev/tty
	exit 0
else
	echo
	echo "Error: la categoría ya existe o no se pudo crear"
	echo "Pulsa una tecla para continuar"
	read -n1 < /dev/tty
	exit 1
fi
