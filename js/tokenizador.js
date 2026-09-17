export function TokenizarFormula(formula) {
    let i = 1;
    let cantidadTokens = 0;
    let textoAcumulado = "";
    let textoTemporal = "";
    let operacionValida = true;
    let letra1 = "";

    while (i <= formula.length && operacionValida === true) {
        textoTemporal = formula[i]
        if (textoTemporal === "[" || textoTemporal === "]" || textoTemporal === "{" || textoTemporal === "}") {
            alert("El símbolo " + textoTemporal + " no estan permitido. Utiliza solo los paréntesis() para agrupar ")
            break
        } else if (textoTemporal === "+" || textoTemporal === "-" || textoTemporal === "*" || textoTemporal === "/" || textoTemporal === "(" || textoTemporal === ")" || textoTemporal === "," || textoTemporal === ";" || textoTemporal === ":" || textoTemporal === "%" || textoTemporal === "^") {
            if (textoAcumulado.length > 0) {
                cantidadTokens = cantidadTokens + 1
                //TODO: Aqui se ingresaria el valor el diccionario, 
                //Pendiente definir e integrar la estructura de datos final.
            }
        }
    }
}

function ObtenerTipoDeDatoNumeroCeldaFuncionRango(textoAcumulado, letra1){
//TODO: Implementar lógica de clasificación para numeros y celdas
}

function ObtenerTipoDeDatoParOperadorSeparadorAgrupador(textoAcumulado){
//TODO: Implementar lógica de clasificación de operadores, separadores y agrupadores
}