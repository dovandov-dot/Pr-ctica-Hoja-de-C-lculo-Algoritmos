Funcion textoSinEspacioEnBlanco <- QuitarEspaciosExtremos(textoOriginal)
	Definir inicio, finTexto Como Entero
	Definir textoSinEspacioEnBlanco Como Texto
	inicio <- 1
	finTexto <- Longitud(textoOriginal)
	textoSinEspacioEnBlanco <- ""
	
	// Cuenta la cantidad de espacio en blanco que hay al principio
	Mientras inicio <= finTexto Y Subcadena(textoOriginal, inicio, inicio) = " " Hacer
		inicio <- inicio + 1
	Fin Mientras
	
	// Cuenta la cantidad de espacio en blanco que hay  al final del texto
	Mientras finTexto >= inicio Y Subcadena(textoOriginal, finTexto, finTexto) = " " Hacer
		finTexto <- finTexto - 1
	Fin Mientras
	
	// Si el inicio superó al final, significa que todo era puro espacio en blanco
	Si inicio > finTexto Entonces
		textoSinEspacioEnBlanco <- ""
	SiNo
		// Extrae la cadena respetando los espacios intermedios (ej. "1 0" o "Hola mundo")
		textoSinEspacioEnBlanco <- Subcadena(textoOriginal, inicio, finTexto)
	Fin Si
FinFuncion

Algoritmo Quitar_Espacio_En_Blanco
	Definir textoHojaCalculo, textoSinEspacioEnBlanco Como Texto
	textoHojaCalculo <- ""
	textoSinEspacioEnBlanco <- ""
	
	Escribir "Ingrese el texto deseado: "
	Leer textoHojaCalculo
	
	textoSinEspacioEnBlanco <- QuitarEspaciosExtremos(textoHojaCalculo)
	
	Escribir "La cantidad de caracteres del texto sin espacios en blanco es: ", Longitud(textoSinEspacioEnBlanco)
	Escribir "La cantidad de caracteres del texto con espacios en blanco es: ",Longitud(textoHojaCalculo)
	
FinAlgoritmo
