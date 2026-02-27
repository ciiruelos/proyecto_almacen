import curses
import os
import subprocess

def listar_subdirectorios(ruta):
	return [d for d in os.listdir(ruta) if os.path.isdir(os.path.join(ruta, d))]

def main(stdscr):
	ruta_padre = "/tiendas/tiendaDam"
	categorias = listar_subdirectorios(ruta_padre)
	if not categorias:
		stdscr.addstr("No hay categorías.\n")
		stdscr.getch()
		return

	seleccion_cat = 0
	while True:
		stdscr.clear()
		stdscr.addstr("Elige la categoría:\n\n")
		for i, d in enumerate(categorias):
			if i == seleccion_cat:
				stdscr.addstr(f"> {d}\n", curses.A_REVERSE)
			else:
				stdscr.addstr(f"  {d}\n")
		stdscr.addstr("\nUsa ↑↓ y Enter")
		key = stdscr.getch()
		if key == curses.KEY_UP and seleccion_cat > 0:
			seleccion_cat -= 1
		elif key == curses.KEY_DOWN and seleccion_cat < len(categorias) - 1:
			seleccion_cat += 1
		elif key == 10:  # Enter
			categoria_seleccionada = os.path.join(ruta_padre, categorias[seleccion_cat])
			marcas = listar_subdirectorios(categoria_seleccionada)
			if not marcas:
				stdscr.clear()
				stdscr.addstr(f"No hay marcas en {categorias[seleccion_cat]}\n")
				stdscr.addstr("Pulsa cualquier tecla para salir...")
				stdscr.getch()
				return

			seleccion_marca = 0
			while True:
				stdscr.clear()
				stdscr.addstr(f"Elige la marca en {categorias[seleccion_cat]}:\n\n")
				for i, m in enumerate(marcas):
					if i == seleccion_marca:
						stdscr.addstr(f"> {m}\n", curses.A_REVERSE)
					else:
						stdscr.addstr(f"  {m}\n")
				stdscr.addstr("\nUsa ↑↓ y Enter")
				key_m = stdscr.getch()
				if key_m == curses.KEY_UP and seleccion_marca > 0:
					seleccion_marca -= 1
				elif key_m == curses.KEY_DOWN and seleccion_marca < len(marcas) - 1:
					seleccion_marca += 1
				elif key_m == 10:  # Enter
					marca_seleccionada = os.path.join(categoria_seleccionada, marcas[seleccion_marca])
					# Salimos de curses antes de llamar al script
					curses.endwin()
					# Ejecutar el .sh en el terminal real
   
					subprocess.run(["bash", "/home/alumno/programa/scripts/bash/crear_producto.sh", marca_seleccionada], stdin=open("/dev/tty"), stdout=open("/dev/tty", "w"), stderr=open("/dev/tty", "w"))
					return

curses.wrapper(main)

