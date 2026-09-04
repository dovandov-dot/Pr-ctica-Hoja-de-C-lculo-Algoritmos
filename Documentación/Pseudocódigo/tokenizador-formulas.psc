Funcion cantidadTokens <- separarTexto (formula, matrixFormula Por Referencia)
	//Declaración de las variables constantes
	Definir ESPACIO, SIGNOIGUAL Como Caracter
	//Declaración de las variables
	Definir i, cantidadTokens, espacioEnBlanco Como Entero
	Definir textoAcumulado Como Texto
	Definir textoTemporal Como Caracter
	Definir operacionValida Como Logico
	Definir letra1 Como Caracter
	//Inicializando variables constantes
	ESPACIO <- " "
	SIGNOIGUAL <- "="
	//Inicializando variables
	textoAcumulado <- ""
	textoTemporal <- ""
	cantidadTokens <- 0
	espacioEnBlanco <- 1 //Para que el bucle while este exactamente en el primer carácter de la fórmula
	i <- 0
	letra1 <- ""
	operacionValida <- Verdadero
	formula <- Mayusculas(formula)
	//para quitar los espacios en blanco entes del signo =
	Mientras espacioEnBlanco <= Longitud(formula) Y Subcadena(formula, espacioEnBlanco, espacioEnBlanco) = ESPACIO Hacer
		espacioEnBlanco <- espacioEnBlanco + 1
	Fin Mientras
	
	Si espacioEnBlanco <= Longitud(formula) Y Subcadena(formula,espacioEnBlanco,espacioEnBlanco) = SIGNOIGUAL Entonces
		//Se inicializa con espaciosEnBlanco+1 el bucle, ya que para quitar el signo = hay que sumar 1 para no tomarlo en cuenta
		i <- espacioEnBlanco + 1
		Mientras i <= Longitud(formula) Y operacionValida = Verdadero Hacer
			textoTemporal <- Subcadena(formula, i, i)
			Si textoTemporal = "[" o textoTemporal = "]" O textoTemporal = "{" O textoTemporal = "}" Entonces
				Escribir "Error: El símbolo ", textoTemporal, " no estan permitido. Utiliza solo los paréntesis() para agrupar "
				operacionValida <- Falso
				cantidadTokens <- 0 //Sirve por si se almacenaron tokens antes de encontrar el error.
			SiNo
				Si textoTemporal = "+" O textoTemporal = "-" O textoTemporal = "*" O textoTemporal = "/" O textoTemporal = "(" O textoTemporal = ")" O textoTemporal = ";" O textoTemporal = ":" O textoTemporal = "%" O textoTemporal ="^" O textoTemporal = "," Entonces
					Si Longitud(textoAcumulado) > 0 Entonces
						cantidadTokens <- cantidadTokens + 1
						matrixFormula[cantidadTokens,2] <- textoAcumulado //Se ingresa el primer el token a la matriz 
						letra1 <- Subcadena(textoAcumulado, 1, 1)
						Si textoAcumulado = "SUMA" O textoAcumulado = "PROMEDIO" O textoAcumulado = "MAX" O textoAcumulado = "MIN" Entonces
							matrixFormula[cantidadTokens, 1] <- "FuncionRango"
						SiNo 
							Si letra1 = "0" O letra1 = "1" O letra1 = "2" O letra1 = "3" O letra1 = "4" O letra1 = "5" O letra1 = "6" O letra1 = "7" O letra1 = "8" O letra1 = "9" Entonces
								matrixFormula[cantidadTokens, 1] <- "Numero"
							SiNo
								matrixFormula[cantidadTokens, 1] <- "Celda"
							FinSi
						FinSi
						textoAcumulado <- "" //Sirve para poder separar las cadenas de texto
					Fin Si
					Si textoTemporal <> "(" Y textoTemporal <> ")"  Entonces
						cantidadTokens <- cantidadTokens + 1
						matrixFormula[cantidadTokens,1] <- "Operador" //Se agrega de que tipo es 
						matrixFormula[cantidadTokens,2] <- textoTemporal //Sirve para poder guardar el signo de operación en la matriz
					SiNo 
						cantidadTokens <- cantidadTokens + 1
						matrixFormula[cantidadTokens,1] <- "Parentesis" //Se agrega de que tipo es 
						matrixFormula[cantidadTokens,2] <- textoTemporal //Sirve para poder guardar el signo de operación en la matriz	
					FinSi
				SiNo
					Si textoTemporal <> ESPACIO Entonces
						textoAcumulado <- textoAcumulado + textoTemporal
					Fin Si
				Fin Si
			Fin Si
			i <- i + 1
		Fin Mientras
		//Ayuda a guardar el último token de la fórmula cuando el último valor no es un operador(+,-,*,/,^,:,;,(,),%)
		Si operacionValida = Verdadero Y Longitud(textoAcumulado) > 0  Entonces
			cantidadTokens <- cantidadTokens + 1
			matrixFormula[cantidadTokens,2] <- textoAcumulado //Sirve para poder guardar el número en la matriz	
			letra1 <- Subcadena(textoAcumulado, 1, 1)
			Si letra1 = "0" O letra1 = "1" O letra1 = "2" O letra1 = "3" O letra1 = "4" O letra1 = "5" O letra1 = "6" O letra1 = "7" O letra1 = "8" O letra1 = "9" Entonces
				matrixFormula[cantidadTokens, 1] <- "Numero"
			SiNo
				matrixFormula[cantidadTokens, 1] <- "Celda"
			FinSi
		FinSi
	SiNo
		Escribir "Error: Formula inválida. Debe comenzar con el signo ="
	FinSi
	
Fin Funcion


Algoritmo Tokenizador_Fórmula
	Definir i, totalTokens Como Entero
	Definir formula, textoSeparado, tokensFormula Como Texto
	formula <- ""
	i<- 1
	totalTokens <- 0
	
	Escribir "Ingresa una formula: "
	Leer formula
	formula <- Mayusculas(formula)
	// La primera columna es el tipo y la segunda el valor 
	Dimension tokensFormula[Longitud(formula),2]
	
	totalTokens <- separarTexto(formula, tokensFormula)
	
	Si totalTokens > 0 Entonces
		Para i<-1 Hasta totalTokens Con Paso 1 Hacer
			Escribir Sin saltar " ", tokensFormula[i,2], " "
		Fin Para
		Escribir "" //Para hacer un salto de línea
	Fin Si
	Si totalTokens > 0 Entonces
		Para i<-1 Hasta totalTokens Con Paso 1 Hacer
			Escribir Sin saltar " ", tokensFormula[i,1], " "
		Fin Para
		Escribir "" //Para hacer un salto de línea
	Fin Si
	
FinAlgoritmo
