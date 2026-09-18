export function TokenizarFormula(formula) {
    const formulaTokenizada = []
    const ESPACIO = " "
    let i = 0;
    let cantidadTokens = 0;
    let textoAcumulado = "";
    let textoTemporal = "";
    let operacionValida = true;
    let letra1 = "";

    while (i < formula.length && operacionValida === true) {
        textoTemporal = formula[i]
        if (textoTemporal === "[" || textoTemporal === "]" || textoTemporal === "{" || textoTemporal === "}") {
            alert("El símbolo " + textoTemporal + " no estan permitido. Utiliza solo los paréntesis() para agrupar ")
            break
        } else if (textoTemporal === "+" || textoTemporal === "-" || textoTemporal === "*" || textoTemporal === "/" || textoTemporal === "(" || textoTemporal === ")" || textoTemporal === "," || textoTemporal === ";" || textoTemporal === ":" || textoTemporal === "%" || textoTemporal === "^") {
            if (textoAcumulado.length > 0) {
                cantidadTokens = cantidadTokens + 1
                letra1 = textoAcumulado[0]
                ObtenerTipoDeDatoNumeroCeldaFuncionRango(textoAcumulado, letra1,formulaTokenizada);
                textoAcumulado = "";
            }
            cantidadTokens = cantidadTokens + 1;
            ObtenerTipoDeDatoParOperadorSeparadorAgrupador(textoTemporal, formulaTokenizada);
        }else{
            if (textoTemporal !== ESPACIO) {
                textoAcumulado = textoAcumulado + textoTemporal;
            }
        }
        i = i + 1;
    }
    return formulaTokenizada;
}

function ObtenerTipoDeDatoNumeroCeldaFuncionRango(textoAcumulado, letra1,formulaTokenizada){
 if (false) {
    //TODO: Aquí, iria la comprobación para saber si se trata de una función rango(PROMEDIO,MAX,MIN,SUMA)
 }else if (letra1 === "0" || letra1 === "1" || letra1 === "2" || letra1 === "3" || letra1 === "4" || letra1 === "5" || letra1 === "6" || letra1 === "7" || letra1 === "8" || letra1 === "9") {
    formulaTokenizada.push({tipo:"Numero", valor:  textoAcumulado})
 }else {
    formulaTokenizada.push({tipo:"Celda", valor:  textoAcumulado})
 }
}

function ObtenerTipoDeDatoParOperadorSeparadorAgrupador(textoTemporal,formulaTokenizada){
    if (textoTemporal === "(" || textoTemporal === ")") {
        formulaTokenizada.push({tipo:"Parentesis", valor:  textoAcumulado})
    } else if (textoTemporal === ":"){
        formulaTokenizada.push({tipo:"OperadorRango", valor:  textoAcumulado})
    }else if (textoTemporal === ";" || textoTemporal === ","){
        formulaTokenizada.push({tipo:"Separador", valor:  textoAcumulado})
    }else {
        formulaTokenizada.push({tipo:"Operador", valor:  textoAcumulado})
    }
}