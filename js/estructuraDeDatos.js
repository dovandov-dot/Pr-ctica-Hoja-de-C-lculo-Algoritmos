export class Celda {
    constructor(valorInicial, idCelda) {
        this.id = idCelda;
        this.textoOriginal = valorInicial;
        this.valorCalculado = valorInicial; // Nivel 2: El valor calculo es el mismo que el ingresado por el usuario
        this.arbolAST = null;
        this.dependencias = [];
        this.dependientes = [];
    }
}

export class EstadoHojaCalculo{
    constructor(){
        this.celdas = {};
    }

    // Método para obtener una celda (Devuelve null si está vacía)
    obtenerCelda(idCelda) {
        return this.celdas[idCelda] || null; 
    }

    actualizarCelda(idCelda, nuevoValor) {
        nuevoValor = nuevoValor.trim(); //la fución strim() realiza el trabajo de mi función para elimiar espacio vacios al inico y final de la cadena de carácteres

        // Si el usuario deja la celda en blanco, se elimina el objeto para liberar memoria
        if (nuevoValor === "") {  
            delete this.celdas[idCelda];
            return;
        }

        if (!this.celdas[idCelda]) {
            this.celdas[idCelda] = new Celda(nuevoValor,idCelda);
        } else{
            this.celdas[idCelda].textoOriginal = nuevoValor;
            this.celdas[idCelda].valorCalculado = nuevoValor;
        }
    }
}

export const EstadoHojaCalculoGlobal = new EstadoHojaCalculo();