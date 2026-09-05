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
		//Se umenta en una para poder saber si se trata de una operación binaria u onitaria del porcentaje
		Si pocisionToken+ 1 <= filas Y tokensFormula[pocisionToken + 1, 1] = "Numero" Entonces
			operador <- tokensFormula[pocisionToken,2]
			pocisionToken <- pocisionToken + 1
			
			numeroDerecho <- operarSignoNegativoPositivo(tokensFormula, pocisionToken,matrizAST, ultimoNodoCreado, filas)
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
	Definir valorLadoIzquierdoDerecho Como Texto
	Definir resultado Como Entero
	resultado <- 0
	valorLadoIzquierdoDerecho <- ""
	
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
			pocisionToken <- pocisionToken + 1
			//Creamos la primera fila del arbol AST
			ultimoNodoCreado <- ultimoNodoCreado + 1
			//Ingresamos todos los datos de los nodos de cada fila 
			matrizAST[ultimoNodoCreado,1] <- "Celda"
			matrizAST[ultimoNodoCreado,2] <- tokensFormula[pocisionToken-1,2]
			matrizAST[ultimoNodoCreado,3] <- "0"
			matrizAST[ultimoNodoCreado,4] <- "0"
			valorLadoIzquierdoDerecho <- ConvertirATexto(ultimoNodoCreado)
		"Parentesis":
			Si  pocisionToken <= filas Y tokensFormula[pocisionToken,2] = "(" Entonces
				//Sirve para no tomar en cuenta el signo de apertura del paréntesis e ir directo a lo que esta adentro de él.
				pocisionToken <- pocisionToken + 1
				//Se opera todo lo esta dentro del paréntesis 
				resultado <- operarSumaResta(tokensFormula, pocisionToken, matrizAST, ultimoNodoCreado, filas)
				
				valorLadoIzquierdoDerecho <- ConvertirATexto(resultado)
				
				Si pocisionToken <= filas Y tokensFormula[pocisionToken,2] <> ")" Entonces
					Escribir "Error: Falta un pararéntesis de cierre en la fórmula"
				SiNo
					pocisionToken <- pocisionToken + 1
				FinSi
			Fin Si
		"FuncionRango":
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
	Definir pocisionToken, ultimoNodoCreado,i, j, contadorFilas, totalTokens, resultadoFinal Como Entero
	Dimension tokensFormula[100,2] //Esta parte de código es para ejemplificar la matrix donde tenemos la formula ya tokenizada
	resultadoFinal <- 0
	pocisionToken <- 1
	ultimoNodoCreado <- 0
	i <- 1
	
	tokensFormula[1,1] = "Parentesis" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[1,2] = "(" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
	tokensFormula[2,1] = "Operador" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[2,2] = "+" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[3,1] = "Numero" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[3,2] = "5" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
	tokensFormula[4,1] = "Operador" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[4,2] = "*" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
	tokensFormula[5,1] = "Numero" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
    tokensFormula[5,2] = "20" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokeniza
	tokensFormula[6,1] = "Parentesis" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizada
	tokensFormula[6,2] = ")" //Esta parte de código es para ejemplificar el array donde tenemos la formula ya tokenizadada
	
	totalTokens <- 6 //Este es en número de filas que se traen del tokenizador 
	contadorFilas <- totalTokens //Es para ejemplificar el dato que me dara el tokenizador
	
	//Se crea una matriz para poder guardar todos los nodos que se van a operarPorcentaje
	//Las columnas son tipo, valor, numeroIzquierdo, numeroDerecho
	Dimension matrizAST(contadorFilas,4)
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
