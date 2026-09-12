Funcion resultadoFormula <- OperarMatrizAST ( matrizAST,ultimoNodoCreado,matrizhojaCalculo)
	Definir resultadoFormula Como Real
	Definir i Como Entero
	Dimension resultadosPrevios[ultimoNodoCreado]
	resultadoFormula <- 0.0
	i <- 1
	
	Para i <- 1 Hasta ultimoNodoCreado Con Paso 1 Hacer
		Segun matrizAST[i,1] Hacer
			"Numero" O "Celda":
				// Extrae el número o el valor de la celda de la hoja de cálculo
				resultadosPrevios[i] <- PasarTextoANumero(matrizAST, i, resultadosPrevios,matrizhojaCalculo)
			"Operador":
				resultadosPrevios[i] <- OperarOperador(matrizAST,i,resultadosPrevios,matrizhojaCalculo)
			"Funcion":
				resultadosPrevios[i] <- OperarFuncionesDeRango(matrizAST, i,resultadosPrevios,matrizhojaCalculo)
			De Otro Modo:
				Escribir "Sigue en construccion"
		Fin Segun
	Fin Para
	resultadoFormula <- resultadosPrevios[ultimoNodoCreado] //Se pone el ultimo nodo ya que es la ultima operación que se realiza en la matriz para obtener el resultado final
Fin Funcion

Funcion resultadoFormula <- OperarFuncionesDeRango(matrizAST, i,resultadosPrevios,matrizhojaCalculo)
	Definir resultadoFormula, acumuladorCeldas Como Real
	Definir nombreFuncion Como Texto
	Definir totalCeldas, numeroIzquierdo Como Entero
	numeroIzquierdo <- ConvertirANumero(matrizAST[i,3]) //Es el numero de fila que contiene todos las celdas o valores a operar
	resultadoFormula <- 0.0
	nombreFuncion <- matrizAST[i,2]
	totalCeldas <- 0
	
	InicializarAcumularCeldas(acumuladorCeldas,nombreFuncion)
	
	ProcesarNodosHijosDeFuncionRango(matrizAST, numeroIzquierdo,resultadosPrevios,nombreFuncion,acumuladorCeldas,totalCeldas,matrizhojaCalculo)
	
	Segun nombreFuncion Hacer
		"SUMA":
			resultadoFormula <- acumuladorCeldas
		"PROMEDIO":
			OperarPromedio(resultadoFormula,acumuladorCeldas,totalCeldas)
		"MIN" O "MAX":
			resultadoFormula <- acumuladorCeldas
		De Otro Modo:
			Escribir "Error: Operacion algebraica no econtrada o disponible. Por favor verifique"
	Fin Segun
	totalCeldas <- 0
	acumuladorCeldas <- 0
FinFuncion 

SubProceso OperarPromedio(resultadoFormula Por Referencia,acumuladorCeldas,totalCeldas)
	Si totalCeldas > 0 Entonces
		resultadoFormula <- acumuladorCeldas / totalCeldas
	SiNo
		Escribir "Error: División por cero en la función PROMEDIO. El rango seleccionado está vacío o no contiene números."
		resultadoFormula <- 0
	Fin Si
FinSubProceso

SubProceso InicializarAcumularCeldas(acumuladorCeldas Por Referencia,nombreFuncion)
	Segun nombreFuncion Hacer
		"MIN":
			acumuladorCeldas <- 9999999999999999999999999999.0 //Sirve por si se evaluan números positivos, ya que si se inicializa en 0 cualquier numero positivo sera mayor por lo que devolera el 0 y nunca me devolvera el valor mínimo de los números positivos que esta analizando la función
		"MAX":
			acumuladorCeldas <- -9999999999999999999999999999.0 //Sirve por si se evaluan números negativos,ya que si se inicializa en 0 me devolvera 0 y no el valor máximo de los números negativos que esta analizando la función
		De Otro Modo:
			acumuladorCeldas <- 0.0
	Fin Segun
	
FinSubProceso

SubProceso ProcesarNodosHijosDeFuncionRango(matrizAST, idFila,resultadosPrevios,nombreFuncion,acumuladorCeldas Por Referencia,totalCeldas Por Referencia,matrizhojaCalculo)
	Definir tipoOperacion Como Texto
	Definir valorYaOperado Como Real
	valorYaOperado <- 0.0
	tipoOperacion <- matrizAST[idFila,1] //Esto nos sirve para analizar el tipo de operación del nodo hijo de la función rango
	
	Segun tipoOperacion Hacer
		"Parametro": // para identificar las comas o punto y coma
			ProcesarNodosHijosDeFuncionRango(matrizAST, ConvertirANumero(matrizAST[idFila, 3]), resultadosPrevios,nombreFuncion,acumuladorCeldas,totalCeldas,matrizhojaCalculo)
			Si ConvertirANumero(matrizAST[idFila, 4]) > 0 Entonces
				ProcesarNodosHijosDeFuncionRango(matrizAST, ConvertirANumero(matrizAST[idFila, 4]), resultadosPrevios, nombreFuncion,acumuladorCeldas,totalCeldas,matrizhojaCalculo)
			Fin Si
		"Rango": // para identificar los ":"
			OperarRango(matrizAST, idFila,resultadosPrevios,nombreFuncion,acumuladorCeldas,totalCeldas,matrizhojaCalculo)
		De Otro Modo:
			valorYaOperado <- resultadosPrevios[idFila]
			ActualizarValoresDeFuncionRango(nombreFuncion,valorYaOperado, acumuladorCeldas,totalCeldas)
			
	Fin Segun
FinSubProceso

SubProceso OperarRango(matrizAST, idFila,resultadosPrevios,nombreFuncion,acumuladorCeldas Por Referencia,totalCeldas Por Referencia,matrizhojaCalculo)
	Definir columnaInicia,columnaFinal,filaInicio,filaFinal, j, k, numeroIzquierdo,numeroDerecho Como Entero
	Definir valorCelda Como Real
	columnaInicia <- 0
	columnaFinal <- 0
	filaInicio <- 0
	filaFinal <- 0
	j <- 0
	k <- 0
	valorCelda <- 0.0
	//Aqui obtenemos el valor de la fila de las celdas donde esta el rango ejemplo: A1:B2
	numeroIzquierdo <- ConvertirANumero(matrizAST[idFila, 3])//Fila donde se encuentra el valor de la celda lado izquierdo
	numeroDerecho <- ConvertirANumero(matrizAST[idFila, 4])//Fila donde se encuentra el valor de la celda lado rerecho
	
	filaInicio <- ConvertirANumero(matrizAST[numeroIzquierdo,3])
	columnaInicia <- TransformarColumnaANumero(matrizAST,numeroIzquierdo)
	filaFinal <- ConvertirANumero(matrizAST[numeroDerecho,4])
	columnaFinal <- TransformarColumnaANumero(matrizAST,numeroDerecho)
	
	//totalCeldas <- filaFinal * columnaFinal se quito porque no tome en cuenta que el valor de la fila y columa inicial no siempre empiezan en 1
	
	Para j <- filaInicio Hasta filaFinal Con Paso 1 Hacer
		Para k <- columnaInicia Hasta columnaFinal Con Paso 1 Hacer
			valorCelda <- matrizhojaCalculo[j,k] //Ejemplicar la matriz de la hoja de calculo
			ActualizarValoresDeFuncionRango(nombreFuncion,valorCelda, acumuladorCeldas,totalCeldas)
		Fin Para
	Fin Para	
FinSubProceso


SubProceso ActualizarValoresDeFuncionRango(nombreFuncion,valorCelda,acumuladorCeldas Por Referencia,totalCeldas Por Referencia)
	Segun nombreFuncion Hacer
		"SUMA" O "PROMEDIO":
			acumuladorCeldas <- acumuladorCeldas + valorCelda
			totalCeldas <- totalCeldas + 1
		"MIN":
			Si valorCelda < acumuladorCeldas Entonces
				acumuladorCeldas <- valorCelda
			Fin Si
		"MAX":
			Si valorCelda > acumuladorCeldas Entonces
				acumuladorCeldas <- valorCelda
			Fin Si
	Fin Segun
FinSubProceso

Funcion resultadoFormula <- OperarOperador(matrizAST, i,resultadosPrevios,matrizhojaCalculo)
	Definir numeroDerecho, numeroIzquierdo, resultadoFormula Como Real
	numeroIzquierdo <- 0.0
	numeroDerecho <- 0.0
	resultadoFormula <- 0.0
	
	numeroDerecho <- ConvertirANumero(matrizAST[i,4])
	numeroIzquierdo <- ConvertirANumero(matrizAST[i,3])
	
	RealizarOperacion(matrizAST, numeroDerecho,numeroIzquierdo,resultadosPrevios,matrizhojaCalculo)
	
	Segun matrizAST[i,2] Hacer
		"%":
			OperarPorcentaje(resultadoFormula,numeroIzquierdo,numeroDerecho)
		"*":
			resultadoFormula <- numeroIzquierdo * numeroDerecho
		"/":
			OperarDivisin(resultadoFormula,numeroIzquierdo,numeroDerecho)
		"+":
			resultadoFormula <- numeroIzquierdo + numeroDerecho
		"-":
			resultadoFormula <- numeroIzquierdo - numeroDerecho
		De Otro Modo:
			Escribir "Erro: Operacion algebraica no econtrada o disponible. Por favor verifique"
	Fin Segun
FinFuncion

Funcion valorNumero <- PasarTextoANumero(matrizAST,idFila,resultadosPrevios,matrizhojaCalculo)
	Si matrizAST[idFila,1] <> "Operador" Entonces //Esto es para verificar cuando ya se ha hecho una operación antes y almacenar su valor
		Si matrizAST[idFila,1] = "Numero" Entonces
			valorNumero <- ConvertirANumero(matrizAST[idFila,2])
		SiNo
			valorNumero <- ObtenerValorCelda(matrizAST,idFila,matrizhojaCalculo)
		Fin Si
	SiNo
		valorNumero <- resultadosPrevios[idFila] //Esto sirve para obtener el resultado almacenado del operador
	Fin Si
FinFuncion

Funcion valorCelda <- ObtenerValorCelda(matrizAST,idFila,matrizhojaCalculo)
	Definir fila, columna Como Entero
	Definir valorCelda Como Real
	Definir textoCelda Como Texto
	fila <- 0
	columna <- 0
	valorCelda <- 0.0
	textoCelda <- ""
	
	Si matrizAST[idFila,1] = "Celda" Entonces
		fila <- ConvertirANumero(matrizAST[idFila,4])
		columna <- TransformarColumnaANumero(matrizAST,idFila)
		textoCelda <- matrizhojaCalculo[fila,columna]
		
		Si VerificarSiEsNumero(textoCelda) = Verdadero  Entonces
			valorCelda <- ConvertirANumero(textoCelda)
		SiNo
			Escribir "Error #¡VALOR!: La celda contiene texto y no se puede operar."//Se frena la ejecución con un tipo brake
			valorCelda <- 0 
		Fin Si
	Fin Si
FinFuncion

Funcion ValorVerificadorBooleano <- VerificarSiEsNumero(textoCelda)
	Definir i, contador Como Entero
	Definir ValorVerificadorBooleano Como Logico
	Definir letraActual Como Caracter
	i <- 1
	contador <- 0
	ValorVerificadorBooleano <- Falso
	letraActual <- ""
	
	Para i <- 1 Hasta Longitud(textoCelda) Con Paso 1 Hacer
		letraActual <- Subcadena(textoCelda,i,i)
		Si  letraActual = "0" O letraActual = "1" O letraActual = "2" O letraActual = "3" O letraActual = "4" O letraActual = "5" O letraActual = "6" O  letraActual = "7" O letraActual = "8" O letraActual = "9" O letraActual = "." Entonces
			contador <- contador + 1 
		Fin Si
	Fin Para
	
	Si contador = Longitud(textoCelda) Y Longitud(textoCelda) > 0 Entonces
		ValorVerificadorBooleano <- Verdadero
	FinSi
FinFuncion

Funcion valorCelda <- TransformarColumnaANumero(matrizAST,idFila)
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
	
	letraColumna  <- matrizAST[idFila,3]
	
	Para i<-1 Hasta Longitud(letraColumna) Con Paso 1 Hacer
		valorLetraActual <- Subcadena(letraColumna,i,i)
		Para j<-1 Hasta Longitud(abecedario)  Con Paso 1 Hacer
			Si valorLetraActual = Subcadena(abecedario, j,j) Entonces
				valorCelda <- (valorCelda * 26) + j
				j <- 27 //Cumple la función como si fuera un break para salir del bucle y no analizar las demas letras de forma incesaria
			Fin Si
		Fin Para
	Fin Para	
FinFuncion

SubProceso RealizarOperacion(matrizAST, numeroDerecho Por Referencia,numeroIzquierdo Por Referencia,resultadosPrevios,matrizhojaCalculo)
	Definir filaNumeroDerecho, filaNumeroIzquierdo Como Entero
	filaNumeroDerecho <- numeroDerecho
	filaNumeroIzquierdo <- numeroIzquierdo
	
	numeroIzquierdo <- PasarTextoANumero(matrizAST,filaNumeroIzquierdo,resultadosPrevios,matrizhojaCalculo) 
	numeroDerecho <- PasarTextoANumero(matrizAST,filaNumeroDerecho,resultadosPrevios,matrizhojaCalculo)
FinSubProceso

SubProceso OperarDivisin(resultadoFormula Por Referencia,numeroIzquierdo,numeroDerecho)
	Si numeroDerecho = 0 Entonces
		Escribir "Erro: no se pueden hacer divisiones entre 0" //Se pondra con un brake para frenar el programa y mostra el error
		resultadoFormula <- 0
	SiNo
		resultadoFormula <- numeroIzquierdo / numeroDerecho
	Fin Si
FinSubProceso

SubProceso OperarPorcentaje(resultadoFormula Por Referencia,numeroIzquierdo,numeroDerecho)
	Si numeroDerecho = 0 Entonces
		resultadoFormula <- numeroIzquierdo/100
	SiNo
		resultadoFormula <- (numeroIzquierdo/100) * numeroDerecho //Se hacer pasi porque funciona sacando el x(numeroIzquierdo) porcentaje de y(numeroDerecho)
	FinSi
FinSubProceso

Algoritmo Evaluador_AST_Formula
	Definir NUMEROCOLUMNAMATRIZAST Como Entero
	NUMEROCOLUMNAMATRIZAST <- 4
	
	Definir contadorFilas, ultimoNodoCreado Como Entero
	Definir resultadoFormula Como Real
	contadorFilas <- 15 //Esto en en base al número de tokens que se obtunvieron de la fórmula tokenizada =30+20*5 / A1+B5-(10-5) con el tokenizador
	ultimoNodoCreado <- 13 //Sirve para ejemplificar la cantidad de filas de la matrizAST que se obtuvo en el analizador sintáctico 
	
	Dimension matrizhojaCalculo[35,16] //Ejemplicar la matriz de la hoja de calculo
	matrizhojaCalculo[1,1] <- "10"
	matrizhojaCalculo[5,2] <- "2"
	
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
	
	resultadoFormula <- OperarMatrizAST(matrizAST,ultimoNodoCreado,matrizhojaCalculo)
	Escribir resultadoFormula

FinAlgoritmo
