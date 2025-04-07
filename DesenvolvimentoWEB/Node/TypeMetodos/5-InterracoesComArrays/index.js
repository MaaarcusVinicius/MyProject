/* Trabalhando com todas funções para trabalhar com ARRAY

 1 - Sort | Reverse - Como vc organiza um ARRAY e faz a ordenação Uzado para ordenação alfabetica do array ( Letras -> Numeros > Caracteres especiais )
 1.1 - Coloquei outro exemplo com numeros no arquivo arrayNumbers.js
 2 - ForEach - extrai o valor e a posição de um Array
 3 - Map - é possivel fazer calculos matematicos dentro do array
 4 - Filter - Filtra igualmente o LIKE do ORACLE
 5 - Reduce - Soma os valores de um array
 6 - Find - Localiza dentro do array o valor - Para no primeiro valor encontrado
*/

const nomesArray =[
  'Marcus',
  'Vinicius',
  'Barros',
  'Araujo',
  '&',
  'Aline',
  'Silva',
  'Gomes' ,'1' ,'2']


  const numbersArray =[
    '1',
    '2',
    '3',
    '4',
    '5',
    '15',
    '27' ]  

console.log("Original Array Nomes: ", nomesArray)

// Sort **** - Uzado para ordenação alfabetica do array ( Letras -> Numeros > Caracteres especiais )
//  Funciona somente com String
console.log('Sort: ', nomesArray.sort())

// Reverse - Uzado para ordenação inversa do array
console.log('Reverse: ', nomesArray.reverse())

// ForEach => 1 Ação ****

nomesArray.forEach((Nomes)=>{
    console.log('O nome é: ', Nomes)
})

nomesArray.forEach((Nomes, index)=>{
  console.log(`A posição do nome ${Nomes} é ${index}.`)
})

// Map
console.log(numbersArray)

const numbersFormatado = numbersArray.map((n)=> n/2)

console.log('Map: ',numbersFormatado)


// Filter  ****

const filtrados = nomesArray.filter((nome)=> nome.charAt(0) === 'A')
console.log('Os nomes que iniciam com a letra A são:' , filtrados)

// Reduce ****

const somaDoArray = numbersArray.reduce((ac, n)=> ac +=n)
console.log('A soma do Array Reduce: ', somaDoArray)


// Find
const itemAchado = nomesArray.find((t) => t === 'Marcus')
console.log('FIND - O nome foi encontrado: ',itemAchado)