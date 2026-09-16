import {HacerTabla} from "./crearTabla.js"
import {EstadoHojaCalculoGlobal} from "./estructuraDeDatos.js"
import {textoSinEspacioEnBlanco} from "./quitarEspaciosEnBlanco.js"

const NUMEROCOLUMNAS = 16;
const NUMEROFILAS = 35;

const tablaHojaCalculo = HacerTabla(NUMEROFILAS,NUMEROCOLUMNAS)
const contenedorTabla = document.getElementById("MatrizHojaCalculo")

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