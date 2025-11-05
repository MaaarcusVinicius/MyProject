/* Arrays
1 - Pop/Push = Adiciona ou remove uma determinada posição(indeci) do array 
2 - Shift | UnShift = Shift ira adiciona sua nova posição no primeiro indici do elemento  UnShift adiciona no ultimo elemento
3 - Splice | Slice = REmove a partir de um elemento
*/

var carrosArray = ['Fiat','Honda','Ford','Chevrolet']

console.log("Array ORIGINAL: ", carrosArray)
// Pop  - Remove o ULTIMO indice do array
carrosArray.pop()
console.log("Pop: ", carrosArray)
console.log("******************************** ")

// Push - Remove o PRIMEIRO indice do array
carrosArray.push()
console.log("Push: ", carrosArray)
console.log("******************************** ")

// Shift | UnShift
carrosArray.shift('Mercedez')
console.log("Push: ", carrosArray)


carrosArray.unshift('BMW')
console.log("unshift: ", carrosArray)
console.log("******************************** ")

var nameArray = ['Marcus','Vinicius','Barros','Araujo']
console.log("Original: ", nameArray)

// Splice | Slice 
nameArray.splice(1,2 ) // remove 
console.log("Splice removeu a posição 2 e 3 do indice: ", nameArray)


nameArray.slice(2,3)
console.log("slice remove a posição a partir do parametro: ", nameArray)