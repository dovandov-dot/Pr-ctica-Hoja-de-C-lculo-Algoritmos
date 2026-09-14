// MÓDULO 1: se ejecuta despues del que el tokenizador realice su función 
SubProceso ExtraerDependencias (celdaDestino, tokensFormula Por Referencia, totalTokens, matrizDependencias Por Referencia, nombresCeldas Por Referencia, totalCeldasRegistradas Por Referencia)
    Definir i, indiceDestino, indiceDependencia Como Entero
    Definir nombreDependencia Como Texto
	i <- 1
	indiceDestino <- 0
	indiceDependencia <- 0
	nombreDependencia <- ""
    
    indiceDestino <- ObtenerIndiceCelda(celdaDestino, nombresCeldas, totalCeldasRegistradas) // Obtenemos el índice numérico de la celda donde el usuario está escribiendo, sirve para poder genera la matriz de dependencias 
    
	// Limpiamos dependencias previas de esta celda (por si el usuario modificó una fórmula existente)
    Para i <- 1 Hasta 100 Hacer
        matrizDependencias[indiceDestino, i] <- 0
    FinPara
    
    // Recorremos los tokens generados por el tokenizador
    Para i <- 1 Hasta totalTokens Hacer
        // Identificamos las celdas leyendo la columna 1 de la matriz de tokens
        Si tokensFormula[i, 1] = "Celda" Entonces
            nombreDependencia <- tokensFormula[i, 2]  // Se cambia el 1 por el 2, yaque en la columna dos es que esta el valor como tal de la celda 
            
            // Obtenemos el índice numérico de la celda de la que dependemos
            indiceDependencia <- ObtenerIndiceCelda(nombreDependencia, nombresCeldas, totalCeldasRegistradas)
            
            // Marcamos la dependencia en la matriz  de adyacencia con un 1 para representar la conexión 
            matrizDependencias[indiceDestino, indiceDependencia] <- 1
        FinSi
    FinPara
FinSubProceso

// Función auxiliar para simular un diccionario. 
// Busca el índice de una celda por su nombre. Si no existe, la registra.
Funcion indice <- ObtenerIndiceCelda (nombreCelda, nombresCeldas Por Referencia, totalCeldasRegistradas Por Referencia)

FinFuncion

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
		totalTokens <- 3
		tokensFormula[1,1] <- "Celda" 
		tokensFormula[1,2] <- "A1"
		tokensFormula[2,1] <- "Operador" 
		tokensFormula[2,2] <- "+"
		tokensFormula[3,1] <- "Celda" 
		tokensFormula[3,2] <- "B2"
		
	// 1. Extraer las dependencias de la matriz de tokens, en el ejemplo seria extraer las celdas A1 y B2
		ExtraerDependencias(celdaEditada, tokensFormula, totalTokens, matrizDependencias, nombresCeldas, totalCeldasRegistradas)
	// 2. Preparar el arreglo de estados (limpiarlo antes de cada comprobación) sirve para que casa celda tenga el valor de 0 e identificar que todavia no se a comprobado esa celda 
		
	// 3. Ejecutar la detección de ciclos	
	
FinAlgoritmo
