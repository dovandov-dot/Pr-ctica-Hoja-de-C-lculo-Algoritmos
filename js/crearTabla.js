export function ObtenerLetraColumna(columna){
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


export function HacerTabla(filas, columnas){
    let columnaEncabezados = 1;
    let filaEncabezado = 1;
    let filaActual =1;
    let columnaActual = 0;
    let letra = "";
    let hojaCalculo = "<table>";
    let idCelda = ""
    let letraIdCelda = ""

    hojaCalculo = hojaCalculo + "<tr>"
    hojaCalculo = hojaCalculo + "<th>i</th>"
    //Para hacer los encabezados de la tabla
    for (columnaEncabezados = 1; columnaEncabezados <= columnas; columnaEncabezados++) {
        letra = ObtenerLetraColumna(columnaEncabezados);
        hojaCalculo = hojaCalculo + "<th>" + letra + "</th>";   
    }
    hojaCalculo = hojaCalculo + "</tr>"
    //Para hacer las filas  de la tabla
    for (filaActual = 1; filaActual <= filas; filaActual++) {
        hojaCalculo = hojaCalculo + "<tr>"
        hojaCalculo = hojaCalculo + "<td>" + filaActual + "</td>"
        for (columnaActual = 1; columnaActual <= columnas; columnaActual++) {
            letraIdCelda = ObtenerLetraColumna(columnaActual)
            idCelda = letraIdCelda + filaActual
            hojaCalculo = hojaCalculo + `<td contenteditable='true' id="${idCelda}"></td>` 
        }
        hojaCalculo = hojaCalculo + "</tr>"
    }
    hojaCalculo = hojaCalculo + "</table>";

    return hojaCalculo
}
