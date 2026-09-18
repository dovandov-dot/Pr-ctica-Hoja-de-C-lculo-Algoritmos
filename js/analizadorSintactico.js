export class AnalizadorSintactico {
    constructor(formulaTokenizada) {
        this.formulaTokenizada = formulaTokenizada;
        this.posicionToken = 0;
    }

    // Arranca el análisis y devuelve el Objeto Raíz (El AST completo)
    parsear() {
        return this.OperarSumaResta();
    }

    OperarSumaResta() {
        let numeroIzquierdo = {};
        let numeroDerecho = {};
        let operador = "";

        numeroIzquierdo = this.OperarMultiplicacionDivision()

        while (this.posicionToken < this.formulaTokenizada.length && this.formulaTokenizada[this.posicionToken].valor === "+" || this.formulaTokenizada[this.posicionToken].valor === "-") {
            operador = this.formulaTokenizada[this.posicionToken].valor;
            this.posicionToken++;

            numeroDerecho = this.OperarMultiplicacionDivision()

            numeroIzquierdo = {tipo: "Operador", valor: operador, numeroIzquierdo: numeroIzquierdo, numeroDerecho: numeroDerecho};
        }
        return numeroIzquierdo
    
    }

    OperarMultiplicacionDivision() {
        let numeroIzquierdo = {};
        let numeroDerecho = {};
        let operador = "";

        numeroIzquierdo = this.OperarPorcentaje()

        while (this.posicionToken < this.formulaTokenizada.length && this.formulaTokenizada[this.posicionToken].valor === "*" || this.formulaTokenizada[this.posicionToken].valor === "/") {
            operador = this.formulaTokenizada[this.posicionToken].valor;
            this.posicionToken++;

            numeroDerecho = this.OperarPorcentaje()

            numeroIzquierdo = {tipo: "Operador", valor: operador, numeroIzquierdo: numeroIzquierdo, numeroDerecho: numeroDerecho};
        }
        return numeroIzquierdo
    }

    OperarPorcentaje() {
        let numeroIzquierdo = {};
        let numeroDerecho = {};
        let operador = "";

        numeroIzquierdo = this.operarSignoNegativoPositivo()

        while (this.posicionToken < this.formulaTokenizada.length && this.formulaTokenizada[this.posicionToken].valor === "%"){
            operador = this.formulaTokenizada[this.posicionToken].valor;
            this.posicionToken++;
            
            if (this.posicionToken + 1 < this.formulaTokenizada.length && this.formulaTokenizada[this.posicionToken + 1].tipo === "Numero") {
                numeroIzquierdo = this.OperarPorcentajeFormaBinaria()
            } else {
                numeroIzquierdo = this.OperarPorcentajeFormaUnitaria()
            }
        }
        return numeroIzquierdo
    }

    OperarPorcentajeFormaBinaria(numeroIzquierdo,operador) {
        let numeroDerecho = {};

        numeroDerecho = this.operarSignoNegativoPositivo()
        return {tipo: "Operador", valor: operador, numeroIzquierdo: numeroIzquierdo, numeroDerecho: numeroDerecho}
    }

    OperarPorcentajeFormaUnitaria() {
    
    }

    operarSignoNegativoPositivo() {
    
    }

    operarNumeroFuncionCeldaParéntesisRango() {
    
    }

    ObtenerNumero() {
    
    }

    ObtenerCelda() {
    
    }

    OperarParentesis() {
    
    }
}


//Mas adelante se agregará la lógica para las fuciones de rango 
//function OperarFuncionRango(formulaTokenizada,posicionToken) {
    
//}

//function ProcesarListaParametros(formulaTokenizada,posicionToken) {
    
//}

//function OperarRango(formulaTokenizada,posicionToken) {
    
//}