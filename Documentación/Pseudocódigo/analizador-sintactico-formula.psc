Funcion resultado <- operarSumaResta (tokensFormula Por Referencia, pocisionToken Por Referencia,matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
	Definir operador Como Caracter
	Definir numeroIzquierdo, numeroDerecho Como Texto
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
	
	numeroIzquierdo <- operarSignoNegativo(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
	
	Mientras pocisionToken <= filas Y tokensFormula[pocisionToken, 2] = "%"  Hacer
		
		Si pocisionToken+ 1 <= filas Y tokensFormula[pocisionToken + 1, 1] = "Numero" Entonces
			operador <- tokensFormula[pocisionToken,2]
			pocisionToken <- pocisionToken + 1
			
			numeroDerecho <- operarSignoNegativo(tokensFormula, pocisionToken,matrizAST, ultimoNodoCreado, filas)
			//Creamos la primera fila del arbol AST
			ultimoNodoCreado <- ultimoNodoCreado +1 
			//Ingresamos todos los datos de los nodos de cada fila
			matrizAST[ultimoNodoCreado,1] <- "Operador"
			matrizAST[ultimoNodoCreado,2] <- operador
			matrizAST[ultimoNodoCreado,3] <- numeroIzquierdo
			matrizAST[ultimoNodoCreado,4] <- numeroDerecho
			numeroIzquierdo <- ConvertirATexto(ultimoNodoCreado)
		SiNo
			operador <- tokensFormula[pocisionToken,2]
			pocisionToken <- pocisionToken + 1
			
			//Creamos la primera fila del arbol AST
			ultimoNodoCreado <- ultimoNodoCreado +1 
			//Ingresamos todos los datos de los nodos de cada fila
			matrizAST[ultimoNodoCreado,1] <- "Operador"
			matrizAST[ultimoNodoCreado,2] <- operador
			matrizAST[ultimoNodoCreado,3] <- numeroIzquierdo
			matrizAST[ultimoNodoCreado,4] <- "0"
			numeroIzquierdo <- ConvertirATexto(ultimoNodoCreado)
		Fin Si
	Fin Mientras
	resultado <- numeroIzquierdo
Fin Funcion

Funcion numeroFila <- operarSignoNegativo(tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia, filas)
	Definir operador Como Caracter
	Definir numeroIzquierdo, numeroDerecho, numeroFila Como Texto
	operador <- ""
	numeroIzquierdo <-  ""
	numeroDerecho <- ""
	numeroFila <- ""
	
	Si  pocisionToken <= filas Y tokensFormula[pocisionToken,2] = "-" Entonces
		operador <- tokensFormula[pocisionToken,2]
		pocisionToken <- pocisionToken + 1
		
		numeroDerecho <- operarNumeroFuncionCeldaParéntesisRango(tokensFormula, pocisionToken,matrizAST, ultimoNodoCreado)
		//Creamos la primera fila del arbol AST
		ultimoNodoCreado <- ultimoNodoCreado + 1
		//Ingresamos todos los datos de los nodos de cada fila 
		matrizAST[ultimoNodoCreado,1] <- "Operador"
		matrizAST[ultimoNodoCreado,2] <- operador
		matrizAST[ultimoNodoCreado,3] <- "0"
		matrizAST[ultimoNodoCreado,4] <- numeroDerecho
		numeroFila <- ConvertirATexto(ultimoNodoCreado)
	SiNo
		numeroFila <- operarNumeroFuncionCeldaParéntesisRango(tokensFormula, pocisionToken,matrizAST, ultimoNodoCreado)
	FinSi
	
Fin Funcion


Funcion valorLadoIzquierdoDerecho <- operarNumeroFuncionCeldaParéntesisRango (tokensFormula Por Referencia, pocisionToken Por Referencia, matrizAST Por Referencia, ultimoNodoCreado Por Referencia)
	Segun tokensFormula[pocisionToken,1] Hacer
		"Numero":
			pocisionToken <- pocisionToken + 1
			//Creamos la primera fila del arbol AST
			ultimoNodoCreado <- ultimoNodoCreado + 1
			//Ingresamos todos los datos de los nodos de cada fila 
			matrizAST[ultimoNodoCreado,1] <- "Numero"
			matrizAST[ultimoNodoCreado,2] <- tokensFormula[pocisionToken-1,2]
			matrizAST[ultimoNodoCreado,3] <- "0"
			matrizAST[ultimoNodoCreado,4] <- "0"
			valorLadoIzquierdoDerecho <- ConvertirATexto(ultimoNodoCreado)
		"Celda":
			valorLadoIzquierdoDerecho <- "Esta función sigue en construccion"
			Escribir  valorLadoIzquierdoDerecho 
		"(":
			valorLadoIzquierdoDerecho <- "Esta función sigue en construccion"
			Escribir  valorLadoIzquierdoDerecho 
		"SUMA":
			valorLadoIzquierdoDerecho <- "Esta función sigue en construccion"
			Escribir  valorLadoIzquierdoDerecho 
		"PROMEDIO":
			valorLadoIzquierdoDerecho <- "Esta función sigue en construccion"
			Escribir  valorLadoIzquierdoDerecho 
		"MAX":
			valorLadoIzquierdoDerecho <- "Esta función sigue en construccion"
			Escribir  valorLadoIzquierdoDerecho 
		"MIN":
			valorLadoIzquierdoDerecho <- "Esta función sigue en construccion"
			Escribir  valorLadoIzquierdoDerecho 
		De Otro Modo:
			valorLadoIzquierdoDerecho <- "Esta función sigue en construccion"
			Escribir  valorLadoIzquierdoDerecho 
	Fin Segun
	
Fin Funcion


Algoritmo Analizador_Sintáctico_Fórmula
	Definir pocisionToken, ultimoNodoCreado,i, j, contadorFilas, resultadoFinal Como Entero
	Dimension tokensFormula[100,2] //Esta parte de código es para ejemplificar la matrix donde tenemos la formula ya tokenizada
	resultadoFinal <- 0
	pocisionToken <- 1
	ultimoNodoCreado <- 0
	i <- 1
	
	tokensFormula[1,1] = "Operador" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[1,2] = "-" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
	tokensFormula[2,1] = "Numero" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[2,2] = "5" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[3,1] = "Operador" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[3,2] = "+" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
	tokensFormula[4,1] = "Numero" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[4,2] = "3" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
	tokensFormula[5,1] = "Operador" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[5,2] = "%" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokeniza
	tokensFormula[6,1] = "Numero" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[6,2] = "2" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizadada
	contadorFilas <- 6 //Es para ejemplificar el dato que me dara el tokenizador
	//Se crea una matriz para poder guardar todos los nodos que se van a operarPorcentaje
//	//Las columnas son tipo, valor, numeroIzquierdo, numeroDerecho
	Dimension matrizAST(100,4)
	resultadoFinal <- operarSumaResta(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, contadorFilas)	
	
	//Indica el número de fila que contiene el nodo raíz(es la última operacion que se realiza para obtener el resultado final)
	Escribir  "El resultado de la opreción es: ", resultadoFinal
	//Es solo para poder verificar que la estructura del árbol AST sea correcta 
	Para i <- 1 Hasta ultimoNodoCreado Con Paso 1 Hacer
		Escribir Sin Saltar i, " "
		Para j <- 1  Hasta 4 Con Paso 1 Hacer
			Escribir Sin Saltar matrizAST[i,j], " "
		Fin Para
		Escribir ""
	Fin Para
FinAlgoritmo
