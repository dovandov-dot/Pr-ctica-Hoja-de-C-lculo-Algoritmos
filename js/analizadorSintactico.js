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

        numeroIzquierdo = this.OperarMultiplicacionDivision();

        while (this.posicionToken < this.formulaTokenizada.length && this.formulaTokenizada[this.posicionToken].valor === "+" || this.formulaTokenizada[this.posicionToken].valor === "-") {
            operador = this.formulaTokenizada[this.posicionToken].valor;
            this.posicionToken++;

            numeroDerecho = this.OperarMultiplicacionDivision();

            numeroIzquierdo = {tipo: "Operador", valor: operador, numeroIzquierdo: numeroIzquierdo, numeroDerecho: numeroDerecho};
        }
        return numeroIzquierdo
    
    }

    OperarMultiplicacionDivision() {
        let numeroIzquierdo = {};
        let numeroDerecho = {};
        let operador = "";

        numeroIzquierdo = this.OperarPorcentaje();

        while (this.posicionToken < this.formulaTokenizada.length && this.formulaTokenizada[this.posicionToken].valor === "*" || this.formulaTokenizada[this.posicionToken].valor === "/") {
            operador = this.formulaTokenizada[this.posicionToken].valor;
            this.posicionToken++;

            numeroDerecho = this.OperarPorcentaje();

            numeroIzquierdo = {tipo: "Operador", valor: operador, numeroIzquierdo: numeroIzquierdo, numeroDerecho: numeroDerecho};
        }
        return numeroIzquierdo
    }

    OperarPorcentaje() {
        let numeroIzquierdo = {};
        let numeroDerecho = {};
        let operador = "";

        numeroIzquierdo = this.operarSignoNegativoPositivo();

        while (this.posicionToken < this.formulaTokenizada.length && this.formulaTokenizada[this.posicionToken].valor === "%"){
            operador = this.formulaTokenizada[this.posicionToken].valor;
            this.posicionToken++;
            
            if (this.posicionToken + 1 < this.formulaTokenizada.length && this.formulaTokenizada[this.posicionToken + 1].tipo === "Numero") {
                numeroIzquierdo = this.OperarPorcentajeFormaBinaria(numeroIzquierdo,operador);
            } else {
                numeroIzquierdo = this.OperarPorcentajeFormaUnitaria(numeroIzquierdo,operador);
            }
        }
        return numeroIzquierdo
    }

    OperarPorcentajeFormaBinaria(numeroIzquierdo,operador) {
        let numeroDerecho = {};

        numeroDerecho = this.operarSignoNegativoPositivo()
        return {tipo: "Operador", valor: operador, numeroIzquierdo: numeroIzquierdo, numeroDerecho: numeroDerecho};
    }

    OperarPorcentajeFormaUnitaria(numeroIzquierdo, operador) {
        return {tipo: "Operador", valor: operador, numeroIzquierdo: numeroIzquierdo, numeroDerecho: null};
    }

    operarSignoNegativoPositivo() {
        let numeroIzquierdo = {};
        let numeroDerecho = {};
        let operador = "";

        if (this.posicionToken < this.formulaTokenizada.length && this.formulaTokenizada[this.posicionToken].valor === "+" || this.formulaTokenizada[this.posicionToken].valor === "-") {
            operador = this.formulaTokenizada[this.posicionToken].valor;
            this.posicionToken++;
            
            numeroDerecho = this.operarSignoNegativoPositivo();

            numeroIzquierdo = {tipo: "Operador", valor: operador, numeroIzquierdo: null, numeroDerecho: numeroDerecho};
        } else {
            numeroIzquierdo = this.operarNumeroFuncionCeldaParéntesisRango();
        }
    }

    operarNumeroFuncionCeldaParéntesisRango() {
        let resultado = "";

        if (this.posicionToken > this.formulaTokenizada.length) {
            alert("Error: La fórmula está incompleta. Falta un número o expresión al final. Completela por favor.");
            return;
        } else {
            switch (this.formulaTokenizada[this.posicionToken].tipo) {
                case "Numero":
                    return resultado = this.ObtenerNumero();
                case "Celda":
                    return resultado = this.ObtenerCelda();
                case "Parentesis":
                    return resultado = this.OperarParentesis();
            
                default:
                    alert("Error: Nose reconoce el valor o la función: " + this.formulaTokenizada[this.posicionToken].valor)
                    break;
            }
        }
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