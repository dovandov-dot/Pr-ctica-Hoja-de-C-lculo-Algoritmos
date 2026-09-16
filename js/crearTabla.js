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
    let columnaEncabezados = 0;
    let filaEncabezado = 1;
    let filaActual =1;
    let columnaActual = 0;
    let letra = "";
    let hojaCalculo = "<table>";

    hojaCalculo = hojaCalculo + "<tr>"
    hojaCalculo = hojaCalculo + "<th>i</th>"
    //Para hacer los encabezados de la tabla
    for (columnaEncabezados = 0; columnaEncabezados < columnas; columnaEncabezados++) {
        letra = ObtenerLetraColumna(columnaEncabezados);
        hojaCalculo = hojaCalculo + "<th>" + letra + "</th>";   
    }
    hojaCalculo = hojaCalculo + "</tr>"

    for (filaActual = 1; filaEncabezado <= filas; filaActual++) {
        hojaCalculo = hojaCalculo + "<tr>"
        hojaCalculo = hojaCalculo + "<td>" + filaActual + "</td>"
        for (columnaActual = 1; columnaActual <= columnas; columnaActual++) {
            hojaCalculo = hojaCalculo + "<td>Dato</td>" 
        }
        hojaCalculo = hojaCalculo + "</tr>"
    }
    hojaCalculo = "</table>";

    document.getElementById("MatrizHojaCalculo").innerHTML = hojaCalculo;
}

function GeneracionTabla(){
    const NUMEROFILAS = 35;
    const NUMEROCOLUMNAS = 16;

    HacerTabla(NUMEROFILAS, NUMEROCOLUMNAS);
}