// Solo se ejecuta si DetectarCicloDFS retornó Falso.
SubProceso PropagarRecalculo (indiceCeldaModificada, matrizDependencias Por Referencia, nombresCeldas Por Referencia, totalCeldasRegistradas,matrizhojaCalculo Por Referencia)
    Definir i, ultimoNodo Como Entero
	Definir nuevoResultado Como Real
	i <- 1
	nuevoResultado <- 0.0
	ultimoNodo <- 0
    
    // Buscamos todas las celdas en el registro
    Para i <- 1 Hasta totalCeldasRegistradas Hacer
        
        // Si la celda de la fila "i" depende de la celda modificada (columna)
        Si matrizDependencias[i, indiceCeldaModificada] = 1 Entonces
            
            // 1. Ejecutar el recálculo para la celda afectada
            Escribir "Propagando cambio... Recalculando celda: ", nombresCeldas[i]
            
			// 1. OBTENER EL AST DE LA MEMORIA CACHE
			// Extraemos la matrizAST_Guardada y su cantidad de nodos (ultimoNodoGuardado)
			
            // Llamamos al evaluador pasándole el nuevo AST de la celda edita 
			//nuevoResultado <- OperarMatrizAST(matrizAST, ultimoNodoCreado, matrizhojaCalculo)
            
            // 2. Llamada recursiva (Reacción en cadena)
            // Como la celda "i" acaba de cambiar su valor numérico, debemos 
            // avisarle a las celdas que dependen de "i" que también se actualicen.
            PropagarRecalculo(i, matrizDependencias, nombresCeldas, totalCeldasRegistradas,matrizhojaCalculo)
            
        FinSi
        
    FinPara
FinSubProceso

Algoritmo Recalculo_En_Cadena 
    Definir totalCeldasRegistradas, indiceCeldaEditada, i, j Como Entero
	
    totalCeldasRegistradas <- 3
	i <- 1
	j <- 1
	indiceCeldaEditada <- 0
	
    Dimension matrizDependencias[totalCeldasRegistradas, totalCeldasRegistradas]
    Dimension nombresCeldas[totalCeldasRegistradas]
    Dimension matrizhojaCalculo[10, 10] // Matriz de prueba
    
    //Inicializar la matriz de dependencias en 0
    Para i <- 1 Hasta totalCeldasRegistradas Hacer
        Para j <- 1 Hasta totalCeldasRegistradas Hacer
            matrizDependencias[i, j] <- 0
        FinPara
    FinPara
    
    // Ingresar los datos de prueba (Simulando la memoria)
    nombresCeldas[1] <- "A1"
    nombresCeldas[2] <- "B1"
    nombresCeldas[3] <- "C1"
    
    // Configurar dependencias
    // B1 (Fila 2) depende de A1 (Columna 1)
    matrizDependencias[2, 1] <- 1 
    // C1 (Fila 3) depende de B1 (Columna 2)
    matrizDependencias[3, 2] <- 1 
    
    // 4. Iniciar la simulación
    Escribir "--- INICIO DE SIMULACIÓN ---"
    Escribir "El usuario acaba de modificar la celda: A1"
    
    // (Aquí iría la lógica donde construyes el AST y evalúas A1)
    Escribir "El nuevo valor de A1 ha sido calculado y guardado."
    Escribir "----------------------------"
    
    // 5. Llamar al subproceso para propagar los cambios
    indiceCeldaEditada <- 1 // El índice de A1 es 1
    PropagarRecalculo(indiceCeldaEditada, matrizDependencias, nombresCeldas, totalCeldasRegistradas, matrizhojaCalculo)
    
    Escribir "----------------------------"
    Escribir "Recálculo en cadena finalizado con éxito."
FinAlgoritmo
