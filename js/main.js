import {HacerTabla} from "./crearTabla.js"
import {EstadoHojaCalculoGlobal} from "./estructuraDeDatos.js"
import {textoSinEspacioEnBlanco} from "./quitarEspaciosEnBlanco.js"
import {TokenizarFormula} from "./tokenizador.js"

const NUMEROCOLUMNAS = 16;
const NUMEROFILAS = 35;

const tablaHojaCalculo = HacerTabla(NUMEROFILAS,NUMEROCOLUMNAS)
const contenedorTabla = document.getElementById("MatrizHojaCalculo")

function ProcesarFormulaIngresada(textoIngresado, idCelda){
    const tokensFormula = TokenizarFormula(textoIngresado)
    //TODO: Aquí se enviaria la fórmula tokenizada al evaluador sintáctico 
    //TODO: Después el resultado se mandaria a guardar al objeto celda 
    //TODO: Por último se procesa el Árbol AST con el evaluador y el resultado se almacena en el objeto celda 
    const celdaActual = EstadoHojaCalculoGlobal.obtenerCelda(idCelda) //Se busca la celda para poder ingresar el árbol AST
    celdaActual.arbolAST = //TODO: se pondría el objeto que genero el evaluador sintáctico

}

if (contenedorTabla){
    contenedorTabla.innerHTML = tablaHojaCalculo

    contenedorTabla.querySelectorAll("td[contenteditable='true']").forEach(celda => {
        celda.addEventListener("blur", function(e){
            const nuevoValor = textoSinEspacioEnBlanco(celda.innerText)
            EstadoHojaCalculoGlobal.actualizarCelda(celda.id, nuevoValor)
        });

        celda.addEventListener("keydown", function(e){
            if (e.key === 'Enter') {
              e.preventDefault(); // Evita que se cree una nueva línea dentro de la celda
              celda.blur(); // Fuerza la pérdida del foco, lo que automáticamente activa el evento 'blur' de arriba
            }
        });
    });
}