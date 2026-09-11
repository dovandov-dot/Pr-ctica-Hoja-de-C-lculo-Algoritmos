Funcion resultado <- operarSumaResta (tokensFormula Por Referencia, pocisionToken Por Referencia,matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
	Definir operador Como Caracter
	Definir numeroIzquierdo, numeroDerecho Como Texto
	Definir resultado Como Entero
	operador <- ""
	numeroIzquierdo <-  ""
	numeroDerecho <- ""
	resultado <- 0
	
	numeroIzquierdo <- operarMultiplicaciónDivisión(tokensFormula, pocisionToken,matrizAST, ultimoNodoCreado, filas)
	
	Mientras  pocisionToken <= filas Y (tokensFormula[pocisionToken,2] = "+" O tokensFormula[pocisionToken,2] = "-") Hacer
		operador <- tokensFormula[pocisionToken,2]
		pocisionToken <- pocisionToken + 1
		
		numeroDerecho <- operarMultiplicaciónDivisión(tokensFormula, pocisionToken,matrizAST, ultimoNodoCreado, filas)
		//Creamos la primera fila del arbol AST
		ultimoNodoCreado <- ultimoNodoCreado + 1
		//Ingresamos todos los datos de los nodos de cada fila 
		matrizAST[ultimoNodoCreado,1] <- "Operador"
		matrizAST[ultimoNodoCreado,2] <- operador
		
		matrizAST[ultimoNodoCreado,3] <- numeroIzquierdo
		matrizAST[ultimoNodoCreado,4] <- numeroDerecho
		numeroIzquierdo <- ConvertirATexto(ultimoNodoCreado)
		
	Fin Mientras
	
	resultado <- ultimoNodoCreado
Fin Funcion

Funcion valorLadoIzquierdoDerecho <- operarMultiplicaciónDivisión (tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
	Definir operador Como Caracter
	Definir numeroIzquierdo, numeroDerecho, valorLadoIzquierdoDerecho Como Texto
	operador <- ""
	numeroDerecho <- ""
	numeroIzquierdo <- ""
	valorLadoIzquierdoDerecho <- ""
	
	numeroIzquierdo <- operarPorcentaje(tokensFormula, pocisionToken,matrizAST, ultimoNodoCreado, filas)
	
	Mientras pocisionToken <= filas Y (tokensFormula[pocisionToken,2] = "*" O tokensFormula[pocisionToken,2] = "/") Hacer
		operador <- tokensFormula[pocisionToken,2]
		pocisionToken <- pocisionToken + 1
		
		numeroDerecho <- operarPorcentaje(tokensFormula, pocisionToken,matrizAST, ultimoNodoCreado, filas)
		//Creamos la primera fila del arbol AST
		ultimoNodoCreado <- ultimoNodoCreado + 1
		//Ingresamos todos los datos de los nodos de cada fila 
		matrizAST[ultimoNodoCreado,1] <- "Operador"
		matrizAST[ultimoNodoCreado,2] <- operador
		matrizAST[ultimoNodoCreado,3] <- numeroIzquierdo
		matrizAST[ultimoNodoCreado,4] <- numeroDerecho
		numeroIzquierdo <- ConvertirATexto(ultimoNodoCreado)
		
	Fin Mientras
	valorLadoIzquierdoDerecho <- numeroIzquierdo
Fin Funcion

Funcion resultado <- operarPorcentaje(tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
	Definir operador Como Caracter
	Definir numeroIzquierdo, numeroDerecho, resultado Como Texto
	operador <- ""
	numeroDerecho <- ""
	numeroIzquierdo <- ""
	resultado <- ""
	
	numeroIzquierdo <- operarSignoNegativoPositivo(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
	
	Mientras pocisionToken <= filas Y tokensFormula[pocisionToken, 2] = "%"  Hacer
		operador <- tokensFormula[pocisionToken,2]
		pocisionToken <- pocisionToken + 1
		//Se aumenta en una para poder saber si se trata de una operación binaria u onitaria del porcentaje
		Si pocisionToken + 1 <= filas Y tokensFormula[pocisionToken + 1, 1] = "Numero" Entonces
			numeroIzquierdo <- OperarPorcentajeFormaBinaria(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas, operador, numeroIzquierdo)
		SiNo
			numeroIzquierdo <- OperarPorcentajeFormaUnitaria(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas, operador, numeroIzquierdo)
		Fin Si
	Fin Mientras
	resultado <- numeroIzquierdo
Fin Funcion

Funcion numeroFila <- OperarPorcentajeFormaBinaria(tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia,filas, operador, numeroIzquierdo)
	Definir numeroDerecho, numeroFila Como Texto
	numeroDerecho <- ""
	numeroFila <- ""
	
	numeroDerecho <- operarSignoNegativoPositivo(tokensFormula, pocisionToken,matrizAST, ultimoNodoCreado, filas)
	//Creamos la primera fila del arbol AST
	ultimoNodoCreado <- ultimoNodoCreado +1 
	//Ingresamos todos los datos de los nodos de cada fila
	matrizAST[ultimoNodoCreado,1] <- "Operador"
	matrizAST[ultimoNodoCreado,2] <- operador
	matrizAST[ultimoNodoCreado,3] <- numeroIzquierdo
	matrizAST[ultimoNodoCreado,4] <- numeroDerecho
	numeroFila<- ConvertirATexto(ultimoNodoCreado)	
	
Fin Funcion

Funcion numeroFila <- OperarPorcentajeFormaUnitaria(tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia,filas, operador, numeroIzquierdo)
	Definir  numeroFila Como Texto
	numeroFila <- ""
	
	//Creamos la primera fila del arbol AST
	ultimoNodoCreado <- ultimoNodoCreado + 1 
	//Ingresamos todos los datos de los nodos de cada fila
	matrizAST[ultimoNodoCreado,1] <- "Operador"
	matrizAST[ultimoNodoCreado,2] <- operador
	matrizAST[ultimoNodoCreado,3] <- numeroIzquierdo
	matrizAST[ultimoNodoCreado,4] <- "0"
	numeroFila <- ConvertirATexto(ultimoNodoCreado)
	
Fin Funcion

Funcion numeroFila <- operarSignoNegativoPositivo(tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
	Definir operador Como Caracter
	Definir numeroIzquierdo, numeroDerecho, numeroFila Como Texto
	operador <- ""
	numeroIzquierdo <-  ""
	numeroDerecho <- ""
	numeroFila <- ""
	
	Si  pocisionToken <= filas Y (tokensFormula[pocisionToken,2] = "-" O tokensFormula[pocisionToken,2] = "+") Entonces
		operador <- tokensFormula[pocisionToken,2]
		pocisionToken <- pocisionToken + 1
		//Se vuele a llamar a la misma función para poder operar cuando haya doble signo - o + 
		numeroDerecho <- operarSignoNegativoPositivo(tokensFormula, pocisionToken,matrizAST, ultimoNodoCreado, filas)
		//Creamos la primera fila del arbol AST
		ultimoNodoCreado <- ultimoNodoCreado + 1
		//Ingresamos todos los datos de los nodos de cada fila 
		matrizAST[ultimoNodoCreado,1] <- "Operador"
		matrizAST[ultimoNodoCreado,2] <- operador
		matrizAST[ultimoNodoCreado,3] <- "0"
		matrizAST[ultimoNodoCreado,4] <- numeroDerecho
		numeroFila <- ConvertirATexto(ultimoNodoCreado)
	SiNo
		numeroFila <- operarNumeroFuncionCeldaParéntesisRango(tokensFormula, pocisionToken,matrizAST, ultimoNodoCreado, filas)
	FinSi
	
Fin Funcion


Funcion valorLadoIzquierdoDerecho <- operarNumeroFuncionCeldaParéntesisRango (tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
	Definir valorLadoIzquierdoDerecho, numeroFila Como Texto
	Definir resultado Como Entero
	resultado <- 0
	valorLadoIzquierdoDerecho <- ""
	numeroFila <- ""
	
	Si pocisionToken > filas Entonces
		valorLadoIzquierdoDerecho <- "0"
		Escribir "Error: La fórmula está incompleta. Falta un número o expresión al final. Completela por favor." //Se colocaría como un break y una ventaja emergente.
	SiNo
		Segun tokensFormula[pocisionToken,1] Hacer
			"Numero":
				valorLadoIzquierdoDerecho <- ObtenerNumero(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
			"Celda":
				valorLadoIzquierdoDerecho <- ObtenerCelda(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
			"Parentesis":
				valorLadoIzquierdoDerecho <- OperarParentesis(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
			"FuncionRango":
				valorLadoIzquierdoDerecho <- OperarFuncionRango(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
			De Otro Modo:
				valorLadoIzquierdoDerecho <- "0"
				Escribir "Error: Nose reconoce el valor o la función: ", tokensFormula[pocisionToken,1], " sigue en construcción."  //Se colocaría como un break y una ventaja emergente.
			Fin Segun
	FinSi
Fin Funcion

Funcion numeroFila <- ObtenerNumero(tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
	Definir numeroFila Como Texto
	numeroFila <- ""
	
	pocisionToken <- pocisionToken + 1
	//Creamos la primera fila del arbol AST
	ultimoNodoCreado <- ultimoNodoCreado + 1
	//Ingresamos todos los datos de los nodos de cada fila 
	matrizAST[ultimoNodoCreado,1] <- "Numero"
	matrizAST[ultimoNodoCreado,2] <- tokensFormula[pocisionToken-1,2] //Se pone una pocisión menos debido a que aumentamos antes una pocisión
	matrizAST[ultimoNodoCreado,3] <- "0" 
	matrizAST[ultimoNodoCreado,4] <- "0" 
	numeroFila <- ConvertirATexto(ultimoNodoCreado)
Fin Funcion

Funcion numeroFila <- ObtenerCelda(tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
	Definir numeroFila, columna, fila Como Texto
	numeroFila <- ""
	columna <- ""
	fila <- ""
	
	SepararColumnaFilaDeCelda(fila, columna,tokensFormula,pocisionToken)
	
	pocisionToken <- pocisionToken + 1
	//Creamos la primera fila del arbol AST
	ultimoNodoCreado <- ultimoNodoCreado + 1
	//Ingresamos todos los datos de los nodos de cada fila 
	matrizAST[ultimoNodoCreado,1] <- "Celda"
	matrizAST[ultimoNodoCreado,2] <- tokensFormula[pocisionToken-1,2]
	matrizAST[ultimoNodoCreado,3] <- columna //Columna 
	matrizAST[ultimoNodoCreado,4] <- fila //Fila 
	numeroFila <- ConvertirATexto(ultimoNodoCreado)
	
	fila <- ""
	columna <- ""
FinFuncion

SubProceso SepararColumnaFilaDeCelda(fila Por Referencia, columna Por Referencia,tokensFormula Por Referencia,pocisionToken Por Referencia)
	Definir letraNumero Como Caracter
	Definir i Como Entero
	i <- 1
	letraNumero <- ""
	
	Para i <- 1 Hasta Longitud(tokensFormula[pocisionToken,2]) Con Paso 1 Hacer
		letraNumero <- subcadena(tokensFormula[pocisionToken,2], i, i)
		Si letraNumero <> "0" Y letraNumero <> "1" Y letraNumero <> "2" Y letraNumero <> "3" Y letraNumero <> "4" Y letraNumero <> "5" Y letraNumero <> "6" Y letraNumero <> "7" Y letraNumero <> "8" Y letraNumero <> "9"  Entonces
			columna <- columna + letraNumero
		SiNo
			Si Longitud(columna) > 0 Entonces
				fila <- fila + letraNumero
			Fin Si
		Fin Si
	Fin Para
FinSubProceso

Funcion numeroFila <- OperarParentesis(tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
	Definir numeroFila Como Texto
	Definir resultado Como Entero
	numeroFila <- ""
	resultado <- 0
	
	Si  pocisionToken <= filas Y tokensFormula[pocisionToken,2] = "(" Entonces
		//Sirve para no tomar en cuenta el signo de apertura del paréntesis e ir directo a lo que esta adentro de él.
		pocisionToken <- pocisionToken + 1
		//Se opera todo lo esta dentro del paréntesis 
		resultado <- operarSumaResta(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
		
		numeroFila <- ConvertirATexto(resultado)
		
		Si pocisionToken > filas O tokensFormula[pocisionToken,2] <> ")" Entonces
			Escribir "Error: Falta un pararéntesis de cierre en la fórmula" //Se colocaría como un break y una ventaja emergente. 
		SiNo
			pocisionToken <- pocisionToken + 1
		FinSi
	Fin Si
FinFuncion

Funcion numeroFila <- OperarFuncionRango(tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
    Definir numeroFila, nombreFuncion, nodoParametros Como Texto
	numeroFila <- ""
	nombreFuncion <- ""
	nodoParametros <- ""
	
    nombreFuncion <- tokensFormula[pocisionToken, 2] // Ej: "SUMA", "PROMEDIO"
    pocisionToken <- pocisionToken + 1 // Avanzamos para verificar si el siguiente caracter es un paréntesis de apertura
    
	Si nombreFuncion <> "SUMA" Y nombreFuncion <> "PROMEDIO" Y nombreFuncion <> "MAX" Y nombreFuncion <> "MIN" Entonces
		Escribir "Error Sintáctico: La función ", nombreFuncion, " no está disponible o no existe. Por favor verifique." //Se colocaría como un break y una ventaja emergente.
        numeroFila <- "0"
	SiNo
		// Verificamos que siga el paréntesis de apertura '('
		Si pocisionToken <= filas Y tokensFormula[pocisionToken, 2] = "(" Entonces
			pocisionToken <- pocisionToken + 1 // Avanzamos para analizar lo que esta dentro del paréntesis 
			
			// Obtenemos los parámetros encadenados (pueden ser rangos separados por coma)
			nodoParametros <- ProcesarListaParametros(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
			
			// Verificamos paréntesis de cierre ')'
			Si pocisionToken <= filas Y tokensFormula[pocisionToken, 2] = ")" Entonces
				CrearFilaEnMatrizASTFuncionRango(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas,nombreFuncion,nodoParametros)
				numeroFila <- ConvertirATexto(ultimoNodoCreado)
			SiNo
				Escribir "Error: Falta ", ")", " al cerrar la función ", nombreFuncion //Se colocaría como un break y una ventaja emergente.
				numeroFila <- "0"
			FinSi
		SiNo
			Escribir "Error: Se esperaba ", "(", " después de ", nombreFuncion //Se colocaría como un break y una ventaja emergente.
			numeroFila <- "0"
		FinSi
	FinSi
FinFuncion

SubProceso CrearFilaEnMatrizASTFuncionRango(tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas,nombreFuncion,nodoParametros)
	pocisionToken <- pocisionToken + 1 // Consumimos ')'
	// Creamos el nodo de la función principal
	ultimoNodoCreado <- ultimoNodoCreado + 1
	matrizAST[ultimoNodoCreado, 1] <- "Funcion"
	matrizAST[ultimoNodoCreado, 2] <- nombreFuncion
	matrizAST[ultimoNodoCreado, 3] <- nodoParametros
	matrizAST[ultimoNodoCreado, 4] <- "0"
FinSubProceso

Funcion nodoActual <- ProcesarListaParametros(tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
    Definir nodoIzquierdo, nodoDerecho, nodoActual Como Texto
	nodoDerecho <- ""
	nodoIzquierdo <- ""
	nodoActual <- ""
    
    // Procesamos el primer parámetro (ej. un Rango A1:A5 o una expresión/celda)
    nodoIzquierdo <- OperarRango(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
    
    // Si hay una coma "," o  ";", procesamos el siguiente parámetro recursivamente
    Si pocisionToken <= filas Y (tokensFormula[pocisionToken, 2] = "," O tokensFormula[pocisionToken, 2] = ";") Entonces
        pocisionToken <- pocisionToken + 1 // Consumimos la "," o ";"
        
        nodoDerecho <- ProcesarListaParametros(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
        
        // Creamos un nodo conector de tipo Parametro (,)
        ultimoNodoCreado <- ultimoNodoCreado + 1
        matrizAST[ultimoNodoCreado, 1] <- "Parametro"
        matrizAST[ultimoNodoCreado, 2] <- ","
        matrizAST[ultimoNodoCreado, 3] <- nodoIzquierdo
        matrizAST[ultimoNodoCreado, 4] <- nodoDerecho
        
        nodoActual <- ConvertirATexto(ultimoNodoCreado)
    SiNo
        nodoActual <- nodoIzquierdo
    FinSi
FinFuncion

Funcion nodoRango <- OperarRango(tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
    Definir nodoIzquierdo, nodoDerecho, nodoRango Como Texto
    nodoIzquierdo <- ""
	nodoDerecho <- ""
	nodoRango <- ""
    // Evaluamos el lado izquierdo 
    nodoIzquierdo <- operarSumaResta(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
    
    // Verificamos si existe el operador de rango ':'
    Si pocisionToken <= filas Y tokensFormula[pocisionToken, 2] = ":" Entonces
        pocisionToken <- pocisionToken + 1 // Consumimos ':'
        
        // Evaluamos el lado derecho 
        nodoDerecho <- operarSumaResta(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
        
        // Creamos el nodo de Rango
        ultimoNodoCreado <- ultimoNodoCreado + 1
        matrizAST[ultimoNodoCreado, 1] <- "Rango"
        matrizAST[ultimoNodoCreado, 2] <- ":"
        matrizAST[ultimoNodoCreado, 3] <- nodoIzquierdo
        matrizAST[ultimoNodoCreado, 4] <- nodoDerecho
        
        nodoRango <- ConvertirATexto(ultimoNodoCreado)
    SiNo
        nodoRango <- nodoIzquierdo
    FinSi
FinFuncion

Algoritmo Analizador_Sintáctico_Fórmula
	Definir NUMEROCOLUMNASMATRIZAST, NUMEROCOLUMNASTOKENSFORMULA Como Entero
	NUMEROCOLUMNASMATRIZAST <- 4
	NUMEROCOLUMNASTOKENSFORMULA <- 2
	
	Definir pocisionToken, ultimoNodoCreado,i, j, contadorFilas, totalTokens, resultadoFinal Como Entero
	Dimension tokensFormula[100,NUMEROCOLUMNASTOKENSFORMULA] //Esta parte de código es para ejemplificar la matrix donde tenemos la formula ya tokenizada
	resultadoFinal <- 0
	pocisionToken <- 1
	ultimoNodoCreado <- 0
	i <- 1
	j <- 1
	
	tokensFormula[1,1] = "Parentesis" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[1,2] = "(" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
	tokensFormula[2,1] = "Operador" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[2,2] = "+" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[3,1] = "Numero" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[3,2] = "5" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
	tokensFormula[4,1] = "Operador" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[4,2] = "*" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
	tokensFormula[5,1] = "Celda" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[5,2] = "AB20" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokeniza
	tokensFormula[6,1] = "Operador" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
	tokensFormula[6,2] = "+" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizadada
	
	totalTokens <- 6 //Este es en número de filas que se traen del tokenizador 
	contadorFilas <- totalTokens //Es para ejemplificar el dato que me dara el tokenizador
	
	//Se crea una matriz para poder guardar todos los nodos que se van a operarPorcentaje
	//Las columnas son tipo, valor, numeroIzquierdo, numeroDerecho
	Dimension matrizAST(contadorFilas,NUMEROCOLUMNASMATRIZAST)
	resultadoFinal <- operarSumaResta(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, contadorFilas)	
	
	//Indica el número de fila que contiene el nodo raíz(es la última operacion que se realiza para obtener el resultado final)
	Escribir  "El resultado de la opreción es: ", resultadoFinal
	//Es solo para poder verificar que la estructura del árbol AST sea correcta 
	Para i <- 1 Hasta ultimoNodoCreado Con Paso 1 Hacer
		Escribir Sin Saltar i, " " //Las " " sirven para dejar un espacion entre cada dato
		Para j <- 1  Hasta NUMEROCOLUMNASMATRIZAST Con Paso 1 Hacer
			Escribir Sin Saltar matrizAST[i,j], " " //Las " " sirven para dejar un espacion entre cada dato
		Fin Para
		Escribir ""//Las "" sirven para poder hacer un salto de línea 
	Fin Para
FinAlgoritmo
