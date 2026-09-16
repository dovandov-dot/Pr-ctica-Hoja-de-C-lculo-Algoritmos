function ObtenerLetraColumna(columna){
    let residuo = 0
    let letra = ""

    while (columna > 0){
        residuo = (columna-1) % 26
        // 65 es el código ASCII para la letra 'A' en JavaScript y String.fromCharCode convierte a sistema ASCII el numero
        letra = String.fromCharCode(65 + residuo) + letra;
        columna = Math.floor((columna-1) / 26);
    }
    return letra;

}

function HacerTabla(filas, columnas){

}

function GeneracionTabla(){
    const NUMEROFILAS = 35;
    const NUMEROCOLUMNAS = 16;

    HacerTabla(NUMEROFILAS, NUMEROCOLUMNAS);
}