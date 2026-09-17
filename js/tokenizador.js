export function TokenizarFormula(formula) {
    const formulaTokenizada = []
    const ESPACIO = " "
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
                letra1 = textoAcumulado[1]
                //TODO: Aqui se ingresaria el valor acumulado el diccionario de objetos independietes, 
                //Pendiente definir e integrar la estructura de datos final.
                ObtenerTipoDeDatoNumeroCeldaFuncionRango(textoAcumulado, letra1,formulaTokenizada);
                textoAcumulado = "";
            }
            cantidadTokens = cantidadTokens + 1;
            //TODO: Aqui se ingresaria el valor del texto temporal el diccionario de objetos independietes, 
            ObtenerTipoDeDatoParOperadorSeparadorAgrupador(textoTemporal, formulaTokenizada);
        }else{
            if (textoTemporal !== ESPACIO) {
                textoAcumulado = textoAcumulado + textoTemporal;
            }
        }
        i = i + 1;
    }
}

function ObtenerTipoDeDatoNumeroCeldaFuncionRango(textoAcumulado, letra1,formulaTokenizada){
//TODO: Implementar lógica de clasificación para numeros y celdas
 if (false) {
    //TODO: Aquí, iria la comprobación para saber si se trata de una función rango(PROMEDIO,MAX,MIN,SUMA)
 }else if (letra1 === "0" || letra1 === "1" || letra1 === "2" || letra1 === "3" || letra1 === "4" || letra1 === "5" || letra1 === "6" || letra1 === "7" || letra1 === "8" || letra1 === "9") {
    //TODO: Aquí se ingresaria el tipo(Número) con su valor al arreglo formulaTokenizada como objeto independiente 
 }else {
    //TODO: Aquí se ingresaria el tipo(Celda) con su valor al arreglo formulaTokenizada como objeto independiente 
 }
}

function ObtenerTipoDeDatoParOperadorSeparadorAgrupador(textoTemporal,formulaTokenizada){
    if (textoTemporal === "(" || textoTemporal === ")") {
        //TODO: Aquí se ingresaria el tipo(Parentesis) con su valor al arreglo formulaTokenizada como objeto independiente 
    } else if (textoTemporal === ":"){
        //TODO: Aquí se ingresaria el tipo(OperadorRango) con su valor al arreglo formulaTokenizada como objeto independiente 
    }else if (textoTemporal === ";" || textoTemporal === ","){
        //TODO: Aquí se ingresaria el tipo(Separador) con su valor al arreglo formulaTokenizada como objeto independiente 
    }else {
        //TODO: Aquí se ingresaria el tipo(Operador) con su valor al arreglo formulaTokenizada como objeto independiente
    }
}