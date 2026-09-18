export class AnalizadorSintactico {
    constructor(formulaTokenizada) {
        this.formulaTokenizada = formulaTokenizada;
        this.posicionToken = 0;
        this.arbolAST = {}
    }

    OperarSumaResta(formulaTokenizada, posicionToken) {
        const arbolAST = {}
        let numeroIzquierdo = {}
        let numeroDerecho = {}
        let resultado = 0

        numeroIzquierdo = OperarMultiplicacionDivision(formulaTokenizada, posicionToken, arbolAST,)

        while (posicionToken < formulaTokenizada.length && formulaTokenizada[posicionToken].valor === "+" || formulaTokenizada[posicionToken].valor === "-") {
            
        }
    
    }

    OperarMultiplicacionDivision(formulaTokenizada,posicionToken,arbolAST) {
    
    }

    OperarPorcentaje(formulaTokenizada,posicionToken) {
    
    }

    OperarPorcentajeFormaBinaria(formulaTokenizada,posicionToken) {
    
    }

    OperarPorcentajeFormaUnitaria(formulaTokenizada,posicionToken) {
    
    }

    operarSignoNegativoPositivo(formulaTokenizada,posicionToken) {
    
    }

    operarNumeroFuncionCeldaParéntesisRango(formulaTokenizada,posicionToken) {
    
    }

    ObtenerNumero(formulaTokenizada,posicionToken) {
    
    }

    ObtenerCelda(formulaTokenizada,posicionToken) {
    
    }

    OperarParentesis(formulaTokenizada,posicionToken) {
    
    }
}


//Mas adelante se agregará la lógica para las fuciones de rango 
//function OperarFuncionRango(formulaTokenizada,posicionToken) {
    
//}

//function ProcesarListaParametros(formulaTokenizada,posicionToken) {
    
//}

//function OperarRango(formulaTokenizada,posicionToken) {
    
//}