Funcion resultadoFormula <- OperarMatrizAST ( matrizAST,ultimoNodoCreado)
	Definir resultadoFormula Como Real
	Definir i Como Entero
	Dimension resultadosPrevios[ultimoNodoCreado]
	resultadoFormula <- 0.0
	i <- 1
	
	Para i <- 1 Hasta ultimoNodoCreado Con Paso 1 Hacer
		Si matrizAST[i,1] = "Operador" Entonces
			resultadosPrevios[i] <- OperarOperador(matrizAST,i,resultadosPrevios)
		SiNo
			Escribir "Sigue en construccion"
		Fin Si
	Fin Para
	resultadoFormula <- resultadosPrevios[ultimoNodoCreado]
Fin Funcion

Funcion resultadoFormula <- OperarFuncionesDeRango(matrizAST, i)
	Definir numeroDerecho, numeroIzquierdo, resultadoFormula Como Real
	numeroIzquierdo <- 0.0
	numeroDerecho <- 0.0
	resultadoFormula <- 0.0
	
	numeroDerecho <- ConvertirANumero(matrizAST[i,4])
	numeroIzquierdo <- ConvertirANumero(matrizAST[i,3])
	
	RealizarOperacion(matrizAST, numeroDerecho,numeroIzquierdo,resultadoFormula)
	
	Segun matrizAST[i,2] Hacer
		"SUMA":
			Escribir "Esta en construccion"
		"PROMEDIO":
			Escribir "Esta en construccion"
		"MIN":
			Escribir "Esta en construccion"
		"MAX":
			Escribir "Esta en construccion"
		De Otro Modo:
			Escribir "Erro: Operacion algebraica no econtrada o disponible. Por favor verifique"
	Fin Segun
FinFuncion

Funcion totalCeldas <- OperarRango(matrizAST, i)
	Si matrizAST[i,1] = "Rango" Entonces
		Escribir "Esta en construccion"
	SiNo
		Escribir "Esta en construccion"
	Fin Si
FinFuncion

Funcion resultadoFormula <- OperarOperador(matrizAST, i,resultado)
	Definir numeroDerecho, numeroIzquierdo, resultadoFormula Como Real
	numeroIzquierdo <- 0.0
	numeroDerecho <- 0.0
	resultadoFormula <- 0.0
	
	numeroDerecho <- ConvertirANumero(matrizAST[i,4])
	numeroIzquierdo <- ConvertirANumero(matrizAST[i,3])
	
	RealizarOperacion(matrizAST, numeroDerecho,numeroIzquierdo,resultado)
	
	Segun matrizAST[i,2] Hacer
		"%":
			resultadoFormula <- numeroIzquierdo % numeroDerecho
		"*":
			resultadoFormula <- numeroIzquierdo * numeroDerecho
		"/":
			Si numeroDerecho = 0 Entonces
				Escribir "Erro: no se pueden hacer divisiones entre 0" //Se pondra con un brake para frenar el programa y mostra el error
				resultadoFormula <- 0
			SiNo
				resultadoFormula <- numeroIzquierdo / numeroDerecho
			Fin Si
		"+":
			resultadoFormula <- numeroIzquierdo + numeroDerecho
		"-":
			resultadoFormula <- numeroIzquierdo - numeroDerecho
		De Otro Modo:
			Escribir "Erro: Operacion algebraica no econtrada o disponible. Por favor verifique"
	Fin Segun
FinFuncion

Funcion valorNumero <- PasarTextoANumeroDerecho(matrizAST,numeroDerecho,resultadoFormula)
	Si matrizAST[numeroDerecho,1] <> "Operador" Entonces
		Si matrizAST[numeroDerecho,1] = "Numero" Entonces
			valorNumero <- ConvertirANumero(matrizAST[numeroDerecho,2])
		SiNo
			valorNumero <- ObtenerValorCeldaDerecha(matrizAST,numeroDerecho)
		Fin Si
	SiNo
		valorNumero <- resultadoFormula[numeroDerecho]
	Fin Si
FinFuncion

Funcion valorNumero <- PasarTextoANumeroIzquierdo(matrizAST,numeroIzquierdo,resultadoFormula)
	Si matrizAST[numeroIzquierdo,1] <> "Operador" Entonces
		Si matrizAST[numeroIzquierdo,1] = "Numero" Entonces
			valorNumero <- ConvertirANumero(matrizAST[numeroIzquierdo,2])
		SiNo
			valorNumero <- ObtenerValorCeldaIzquierda(matrizAST,numeroIzquierdo)
		Fin Si
	SiNo
		valorNumero <- resultadoFormula[numeroIzquierdo]
	Fin Si
FinFuncion

Funcion valorCelda <- ObtenerValorCeldaIzquierda(matrizAST,numeroIzquierdo)
	Definir fila, columna Como Entero
	Definir valorCelda Como Real
	Dimension matrizhojaCalculo[35,16] //Ejemplicar la matriz de la hoja de calculo
	fila <- 0
	columna <- 0
	valorCelda <- 0.0
	
	matrizhojaCalculo[1,1] <- 10
	matrizhojaCalculo[5,2] <- 2

	Si matrizAST[numeroIzquierdo,1] = "Celda" Entonces
		fila <- ConvertirANumero(matrizAST[numeroIzquierdo,4])
		columna <- TransformarColumnaIzquierdaANumero(matrizAST,numeroIzquierdo)
		valorCelda <- matrizhojaCalculo[fila,columna]
	Fin Si
FinFuncion

Funcion valorCelda <- ObtenerValorCeldaDerecha(matrizAST,numeroDerecho)
	Definir fila, columna Como Entero
	Definir valorCelda Como Real
	Dimension matrizhojaCalculo[35,16] //Ejemplicar la matriz de la hoja de calculo
	fila <- 0
	columna <- 0
	valorCelda <- 0.0
	
	matrizhojaCalculo[1,1] <- 10
	matrizhojaCalculo[5,2] <- 2
	
	Si matrizAST[numeroDerecho,1] = "Celda" Entonces
		fila <- ConvertirANumero(matrizAST[numeroDerecho,4])
		columna <- TransformarColumnaDerechaANumero(matrizAST,numeroDerecho)
		valorCelda <- matrizhojaCalculo[fila,columna]
	Fin Si
FinFuncion

Funcion valorCelda <- TransformarColumnaIzquierdaANumero(matrizAST,numeroIzquierdo)
	Definir letraColumna, abecedario Como Texto
	Definir valorLetra, i,j,valorCelda Como Entero
	Definir valorLetraActual Como Caracter
	letraColumna <- ""
	abecedario <- "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	valorLetra <- 0
	i <- 1
	j <- 1
	valorLetraActual <- ""
	valorCelda <- 0
	
	letraColumna  <- matrizAST[numeroIzquierdo,3]
	
	Para i<-1 Hasta Longitud(letraColumna) Con Paso 1 Hacer
		valorLetraActual <- Subcadena(letraColumna,i,i)
		Para j<-1 Hasta Longitud(abecedario)  Con Paso 1 Hacer
			Si valorLetraActual = Subcadena(abecedario, j,j) Entonces
				valorCelda <- (valorCelda * 26) + j
			Fin Si
		Fin Para
	Fin Para	
FinFuncion

Funcion valorCelda <- TransformarColumnaDerechaANumero(matrizAST,numeroDerecho)
	Definir letraColumna, abecedario Como Texto
	Definir valorLetra, i,j,valorCelda Como Entero
	Definir valorLetraActual Como Caracter
	letraColumna <- ""
	abecedario <- "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	valorLetra <- 0
	i <- 1
	j <- 1
	valorLetraActual <- ""
	valorCelda <- 0
	
	letraColumna  <- matrizAST[numeroDerecho,3]
	
	Para i<-1 Hasta Longitud(letraColumna) Con Paso 1 Hacer
		valorLetraActual <- Subcadena(letraColumna,i,i)
		Para j<-1 Hasta Longitud(abecedario)  Con Paso 1 Hacer
			Si valorLetraActual = Subcadena(abecedario, j,j) Entonces
				valorCelda <- (valorCelda * 26) + j
			Fin Si
		Fin Para
	Fin Para
FinFuncion

SubProceso RealizarOperacion(matrizAST, numeroDerecho Por Referencia,numeroIzquierdo Por Referencia,resultadoFormula)
	Definir filaNumeroDerecho, filaNumeroIzquierdo Como Entero
	filaNumeroDerecho <- numeroDerecho
	filaNumeroIzquierdo <- numeroIzquierdo
	
	numeroIzquierdo <- PasarTextoANumeroIzquierdo(matrizAST,filaNumeroIzquierdo,resultadoFormula) 
	numeroDerecho <- PasarTextoANumeroDerecho(matrizAST,filaNumeroDerecho,resultadoFormula)
FinSubProceso

Algoritmo Evaluador_AST_Formula
	Definir NUMEROCOLUMNAMATRIZAST Como Entero
	NUMEROCOLUMNAMATRIZAST <- 4
	
	Definir contadorFilas, ultimoNodoCreado Como Entero
	Definir resultadoFormula Como Real
	contadorFilas <- 15 //Esto en en base al número de tokens que se obtunvieron de la fórmula tokenizada =30+20*5 / A1+B5-(10-5) con el tokenizador
	ultimoNodoCreado <- 13 //Sirve para ejemplificar la cantidad de filas de la matrizAST que se obtuvo en el analizador sintáctico 
	Dimension matrizAST[contadorFilas, NUMEROCOLUMNAMATRIZAST]
	//La matrizAST es la representaciòn de la fórmula 30+20*5 / A1+B5-(10-5)
	matrizAST[1,1] <- "Numero"
	matrizAST[1,2] <- "30"
	matrizAST[1,3] <- "0"
	matrizAST[1,4] <- "0"
	matrizAST[2,1] <- "Numero"
	matrizAST[2,2] <- "20"
	matrizAST[2,3] <- "0"
	matrizAST[2,4] <- "0"
	matrizAST[3,1] <- "Numero"
	matrizAST[3,2] <- "5"
	matrizAST[3,3] <- "0"
	matrizAST[3,4] <- "0"
	matrizAST[4,1] <- "Operador"
	matrizAST[4,2] <- "*"
	matrizAST[4,3] <- "2"
	matrizAST[4,4] <- "3"
	matrizAST[5,1] <- "Celda"
	matrizAST[5,2] <- "A1"
	matrizAST[5,3] <- "A"
	matrizAST[5,4] <- "1"
	matrizAST[6,1] <- "Operador"
	matrizAST[6,2] <- "/"
	matrizAST[6,3] <- "4"
	matrizAST[6,4] <- "5"
	matrizAST[7,1] <- "Operador"
	matrizAST[7,2] <- "+"
	matrizAST[7,3] <- "1"
	matrizAST[7,4] <- "6"
	matrizAST[8,1] <- "Celda"
	matrizAST[8,2] <- "B5"
	matrizAST[8,3] <- "B"
	matrizAST[8,4] <- "5"
	matrizAST[9,1] <- "Operador"
	matrizAST[9,2] <- "+"
	matrizAST[9,3] <- "7"
	matrizAST[9,4] <- "8"
	matrizAST[10,1] <- "Numero"
	matrizAST[10,2] <- "10"
	matrizAST[10,3] <- "0"
	matrizAST[10,4] <- "0"
	matrizAST[11,1] <- "Numero"
	matrizAST[11,2] <- "5"
	matrizAST[11,3] <- "0"
	matrizAST[11,4] <- "0"
	matrizAST[12,1] <- "Operador"
	matrizAST[12,2] <- "-"
	matrizAST[12,3] <- "10"
	matrizAST[12,4] <- "11"
	matrizAST[13,1] <- "Operador"
	matrizAST[13,2] <- "-"
	matrizAST[13,3] <- "9"
	matrizAST[13,4] <- "12"
	
	
	resultadoFormula <- OperarMatrizAST(matrizAST,ultimoNodoCreado)
	Escribir resultadoFormula

FinAlgoritmo
