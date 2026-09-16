import {HacerTabla} from "./crearTabla.js"

const NUMEROCOLUMNAS = 16;
const NUMEROFILAS = 35;

const tablaHojaCalculo = HacerTabla(NUMEROFILAS,NUMEROCOLUMNAS)
const contenedorTabla = document.getElementById("MatrizHojaCalculo")

if (contenedorTabla){
    contenedorTabla.innerHTML = tablaHojaCalculo
}
