/* Trabalhando com numeros

1 - toString = Converte o numero em uma String
    Obs: O console.log retornar uma coloração diferente quando é um numero "Amarelo" e "branco" quando for uma String
2 - toFixed = Limita a quantidade de casas decimais de um numero, semelhante ao ROUND do Oracle
3 - toPrecision = Pega por base a quantidade de casa decimais possiveis a serem retornadas do valor
4 - 
*/

var number = 105.798111
console.log("O valor original é: ", number)

// 1 - toString
console.log("Usando toString: ", number.toString())

// 2 - toFixed
console.log("Usando toFixe: ", number.toFixed(2))

// 3 - toPrecision
console.log("Usando toPrecision: ", number.toPrecision(12))