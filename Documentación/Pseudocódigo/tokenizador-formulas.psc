Funcion cantidadTokens <- separarTexto (formula, textoSeparado Por Referencia)
	//Declaración de las variables constantes
	Definir ESPACIO, SIGNOIGUAL Como Caracter
	//Declaración de las variables
	Definir i, cantidadTokens, espacioEnBlanco Como Entero
	Definir textoAcumulado Como Texto
	Definir textoTemporal Como Caracter
	Definir operacionValida Como Logico
	//Inicializando variables constantes
	ESPACIO <- " "
	SIGNOIGUAL <- "="
	//Inicializando variables
	textoAcumulado <- ""
	textoTemporal <- ""
	cantidadTokens <- 0
	espacioEnBlanco <- 1 //Para que el el bucle while que exactamente el esta el indice del signo =
	i <- 0
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
						textoSeparado[cantidadTokens] <- textoAcumulado
						textoAcumulado <- "" //Sirve para poder separar las cadenas de texto
					Fin Si
					cantidadTokens <- cantidadTokens + 1
					textoSeparado[cantidadTokens] <- textoTemporal
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
			textoSeparado[cantidadTokens] <- textoAcumulado
		FinSi
	SiNo
		Escribir "Error: Formula inválida. Debe comenzar con el signo ="
	FinSi
	
Fin Funcion


Algoritmo Tokenizador_Fórmula
	Definir i, totalTokens Como Entero
	Definir formula, textoSeparado Como Texto
	formula <- ""
	i<- 1
	totalTokens <- 0
	
	Escribir "Ingresa una formula: "
	Leer formula
	
	Dimension  textoSeparado[Longitud(formula)]
	
	totalTokens <- separarTexto(formula, textoSeparado)
	
	Si totalTokens > 0 Entonces
		Para i<-1 Hasta totalTokens Con Paso 1 Hacer
			Escribir Sin saltar " ", textoSeparado[i], " "
		Fin Para
		Escribir "" //Para hacer un salto de línea
	Fin Si
	
FinAlgoritmo
