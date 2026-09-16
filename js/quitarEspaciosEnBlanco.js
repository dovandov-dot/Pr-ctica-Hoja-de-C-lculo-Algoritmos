export function textoSinEspacioEnBlanco(textoOriginal){
    let inico = 0
    let finTexto = textoOriginal.length
    let textoSinEspacioEnBlanco = ""

    while (inico <= finTexto &&  textoOriginal[inico] === " ") {
        inico++;
    }

    while (finTexto >= inico && textoOriginal[finTexto === " "]) {
        finTexto--;
    }

    if (inico > finTexto) {
        return textoSinEspacioEnBlanco = ""
    }else{
        return textoSinEspacioEnBlanco = textoOriginal.substring(inico,finTexto + 1);
    }

}