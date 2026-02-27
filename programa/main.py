import curses
import subprocess


#funcion para crear
def crear(terminal):
	opciones = ["Categoria", "Marca", "Producto", "Volver"]
	seleccion = 0

	while True:
		terminal.clear()
		terminal.addstr("¿Qué quieres crear?\n", curses.A_BOLD | curses.A_UNDERLINE)

		for i, opcion in enumerate(opciones):
			if i == seleccion:
				terminal.addstr(f"> {opcion}\n", curses.A_REVERSE)
			else:
				terminal.addstr(f"  {opcion}\n")

		terminal.refresh()
		key = terminal.getch()

		if key == curses.KEY_UP and seleccion > 0:
			seleccion -= 1
		elif key == curses.KEY_DOWN and seleccion < len(opciones) - 1:
			seleccion += 1
		elif key in [curses.KEY_ENTER, ord('\n')]:
			if seleccion == 0:
				curses.endwin()
				subprocess.run(["bash", "/home/alumno/programa/scripts/bash/crear_categoria.sh"])
				return
			elif seleccion == 1:
				curses.endwin()
				subprocess.run(["python3", "/home/alumno/programa/scripts/python/elegir_marca.py"])
				return
			elif seleccion == 2:
				curses.endwin()
				subprocess.run(["python3", "/home/alumno/programa/scripts/python/crear_producto.py"])
				return
			elif seleccion == 3:
				return


#funcion para buscar
def buscar(terminal):
	opciones = ["Busqueda por descripcion", "Busqueda por codigo", "Volver"]
	seleccion = 0

	while True:
		terminal.clear()
		terminal.addstr("¿Cómo quieres buscar?\n", curses.A_BOLD | curses.A_UNDERLINE)

		for i, opcion in enumerate(opciones):
			if i == seleccion:
				terminal.addstr(f"> {opcion}\n", curses.A_REVERSE)
			else:
				terminal.addstr(f"  {opcion}\n")

		terminal.refresh()
		key = terminal.getch()

		if key == curses.KEY_UP and seleccion > 0:
			seleccion -= 1
		elif key == curses.KEY_DOWN and seleccion < len(opciones) - 1:
			seleccion += 1
		elif key in [curses.KEY_ENTER, ord('\n')]:
			if seleccion == 0:
				curses.endwin()
				subprocess.run(["bash", "/home/alumno/programa/scripts/bash/buscar_descripcion.sh"])
				return
			elif seleccion == 1:
				curses.endwin()
				subprocess.run(["bash", "/home/alumno/programa/scripts/bash/buscar_codigo.sh"])
				return
			elif seleccion == 2:
				return


#funcion para confirmar salida
def confirmar_salida(terminal):
	opciones = ["No", "Sí"]
	seleccion = 0

	while True:
		terminal.clear()
		terminal.addstr("¿Estás seguro de que deseas salir?\n", curses.A_BOLD | curses.A_UNDERLINE)

		for i, opcion in enumerate(opciones):
			if i == seleccion:
				terminal.addstr(f"> {opcion}\n", curses.A_REVERSE)
			else:
				terminal.addstr(f"  {opcion}\n")

		terminal.refresh()
		key = terminal.getch()

		if key == curses.KEY_UP and seleccion > 0:
			seleccion -= 1
		elif key == curses.KEY_DOWN and seleccion < len(opciones) - 1:
			seleccion += 1
		elif key in [curses.KEY_ENTER, ord('\n')]:
			return seleccion == 1  # True si es "Sí"


#menu
def menu(terminal):
	opciones = ["Crear", "Buscar", "Salir"]
	seleccion = 0

	while True:
		terminal.clear()
		terminal.addstr("Menu de Opciones\n", curses.A_BOLD | curses.A_UNDERLINE)

		for i, opcion in enumerate(opciones):
			if i == seleccion:
				terminal.addstr(f"> {opcion}\n", curses.A_REVERSE)
			else:
				terminal.addstr(f"  {opcion}\n")

		terminal.refresh()
		key = terminal.getch()

		if key == curses.KEY_UP and seleccion > 0:
			seleccion -= 1
		elif key == curses.KEY_DOWN and seleccion < len(opciones) - 1:
			seleccion += 1
		elif key in [curses.KEY_ENTER, ord('\n')]:
			if seleccion == 0:
				crear(terminal)
			elif seleccion == 1:
				buscar(terminal)
			elif seleccion == 2:
				if confirmar_salida(terminal):
					break


if __name__ == "__main__":
	print("Iniciando el menu...")

	terminal = curses.initscr()
	terminal.keypad(True)
	curses.noecho()
	curses.cbreak()
	curses.curs_set(0)

	try:
		menu(terminal)
	finally:
		curses.nocbreak()
		terminal.keypad(False)
		curses.echo()
		curses.endwin()

