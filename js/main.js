import {HacerTabla} from "./crearTabla.js"
import {EstadoHojaCalculoGlobal} from "./estructuraDeDatos.js"
import {textoSinEspacioEnBlanco} from "./quitarEspaciosEnBlanco.js"
import {TokenizarFormula} from "./tokenizador.js"
import {AnalizadorSintactico} from "./analizadorSintactico.js"

const NUMEROCOLUMNAS = 16;
const NUMEROFILAS = 35;

const tablaHojaCalculo = HacerTabla(NUMEROFILAS,NUMEROCOLUMNAS)
const contenedorTabla = document.getElementById("MatrizHojaCalculo")

function ProcesarFormulaIngresada(formulaIngresado, idCelda){
    const tokensFormula = TokenizarFormula(formulaIngresado);
    const analizadorSintactico = new AnalizadorSintactico(formulaIngresado);
    const arbolAST = analizadorSintactico.parsear();

    const celdaActual = EstadoHojaCalculoGlobal.obtenerCelda(idCelda) //Se busca la celda para poder ingresar el árbol AST
    celdaActual.arbolAST = arbolAST
    //TODO: Por último se procesa el Árbol AST con el evaluador y el resultado se almacena en el objeto celda 
    console.log(`Fórmula: ${formulaIngresado}`, tokensFormula); //Para probar la funcionalidad del tokenizador
}

if (contenedorTabla){
    contenedorTabla.innerHTML = tablaHojaCalculo

    contenedorTabla.querySelectorAll("td[contenteditable='true']").forEach(celda => {
        celda.addEventListener("blur", function(e){
            const nuevoValor = textoSinEspacioEnBlanco(celda.innerText).toUpperCase()
            EstadoHojaCalculoGlobal.actualizarCelda(celda.id, nuevoValor)
            if (nuevoValor[0] === "=") {
                let formula = nuevoValor.substring(1)
                ProcesarFormulaIngresada(formula, celda.id)
            }
        });

        celda.addEventListener("keydown", function(e){
            if (e.key === 'Enter') {
              e.preventDefault(); // Evita que se cree una nueva línea dentro de la celda
              celda.blur(); // Fuerza la pérdida del foco, lo que automáticamente activa el evento 'blur' de arriba
            }
        });
    });
}