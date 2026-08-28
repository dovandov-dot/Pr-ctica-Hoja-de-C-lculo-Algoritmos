Funcion letra <- obtenerLetraColumna (columna)
	//Se utilizará el sistema ASCII para convertir los números de las columnas a letras
	Definir residuo Como Entero
	Definir letra, abecedario Como Texto
	residuo <- 0
	letra <- ""
	// La cadena con 26 letras sirve para silumar la función String.fromCharCode() de JavaScript que convierte
	//Los números en carácteres ASCII
    abecedario <- "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	Mientras columna > 0 Hacer
		residuo = (columna-1) % 26
		letra <- Concatenar(Subcadena(abecedario, residuo+1, residuo+1), letra)
		columna = Trunc((columna-1)/26)
	Fin Mientras

Fin Funcion

Funcion hacerTabla (filas, columnas)
	Definir columnaEncabezados, filaEncabezado, filaActual, columnaActual Como Entero
	Definir letra Como Texto
	
	Para filaEncabezado<-1 Hasta 1 Con Paso 1 Hacer
		//Se crear una fila con un <tr> de html
		Escribir Sin Saltar "i"//Aquí se imprimiria como <th> de html para mostrar el encabezado de losíndices
		Para columnaEncabezados<-1 Hasta columnas Con Paso 1 Hacer
			letra <- obtenerLetraColumna(columnaEncabezados)
			Escribir Sin Saltar "  ", letra,"   "//Todo esto iria en un <th> html vació para genera las celdas
		Fin Para
		Escribir "" //Es solo para silumar el salto de fila en la tabla
		//Aqui se cerraria con un </tr> para terminar la fila
	Fin Para
	
	Para filaActual<-1 Hasta filas Con Paso 1 Hacer
		//Aquí se insertaria primero un <tr> de html para generar la fila
		Escribir Sin Saltar filaActual//Aquí se imprimiria como <td> de html para mostrar el índice
		Para columnaActual<-1 Hasta columnas Con Paso 1 Hacer
			Escribir Sin Saltar " Dato "//Todo esto iria en un <td> html vació para genera las celdas
		Fin Para
		Escribir "" //Es solo para silumar el salto de fila en la tabla
		//Aqui se cerraria con un </tr> para terminar la fila
	Fin Para
	
Fin Funcion

Algoritmo Generacion_Tabla
	Definir NUMEROCOLUMNAS,NUMEROFILAS Como Entero
	NUMEROFILAS <- 35
	NUMEROCOLUMNAS <- 16
	
	hacerTabla(NUMEROFILAS, NUMEROCOLUMNAS)
	
FinAlgoritmo
