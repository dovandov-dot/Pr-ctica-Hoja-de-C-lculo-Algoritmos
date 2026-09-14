Algoritmo Detección_De_Referencias_Circulares
	Definir NUMEROCOLUMNASTOKENSFORMULA, MAX_CELDAS Como Entero
    NUMEROCOLUMNASTOKENSFORMULA <- 2
    MAX_CELDAS <- 100 // Límite arbitrario para la simulación 
    
    Definir tokensFormula, nombresCeldas, celdaEditada Como Texto
    Definir matrizDependencias, estados Como Entero
    Definir totalTokens, totalCeldasRegistradas, indiceCeldaEditada, i Como Entero
    Definir errorCircular Como Logico
    
    Dimension tokensFormula[MAX_CELDAS, NUMEROCOLUMNASTOKENSFORMULA]
    Dimension nombresCeldas[MAX_CELDAS]
    Dimension matrizDependencias[MAX_CELDAS, MAX_CELDAS]
    Dimension estados[MAX_CELDAS]
    
    totalCeldasRegistradas <- 0
    errorCircular <- Falso
	indiceCeldaEditada <- 0
	i <- 1
	celdaEditada <- ""
	
	// Inicializar matrices en 0 para simular que esta vacio nuestro arreglo 
	Para i <- 1 Hasta MAX_CELDAS Hacer
        estados[i] <- 0
        nombresCeldas[i] <- ""
    FinPara
	
	// A modo de prueba el usuario edita la celda "C1"
    celdaEditada <- "C1"
	
	//Ejemplo: el usuario ingreo la fórmula "=A1+B2" y el tokenizador nos genero la siguiente matriz 
		totalTokens <- 4
		tokensFormula[1,1] <- "Celda" 
		tokensFormula[1,2] <- "A1"
		tokensFormula[2,1] <- "Operador" 
		tokensFormula[2,2] <- "+"
		tokensFormula[3,1] <- "Celda" 
		tokensFormula[3,2] <- "B2"
		tokensFormula[4,1] <- "Operador"
		tokensFormula[4,2] <- "+"
		
	// 1. Extraer las dependencias de la matriz de tokens, en el ejemplo seria extraer las celdas A1 y B2
		
	// 2. Preparar el arreglo de estados (limpiarlo antes de cada comprobación) sirve para que casa celda tenga el valor de 0 e identificar que todavia no se a comprobado esa celda 
		
	// 3. Ejecutar la detección de ciclos	
	
FinAlgoritmo
