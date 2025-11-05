/* Metodos de Strings

1 - Length = Retorna a quantidade de caracteres dentro de uma string
2 - indexof = Busca a posição do caracter dentro de uma string
3 - search = Busca uma palavra dentro da string
4 - Slice | Substring = Busca o intervalo de uma string
5 - Replace = Altera um valor definido por outro valor definido
6 - UpperCase | LowerCase = Define se o campo string será caixa alta ou caixa baixa
6 - Trim = Retira espaços ao inicio e ou ao final de uma string
7 - CharAt = Mostra a posição de um caracter dentro da String
*/

// 1° Length

var text = "Bem Vindo a Siac Sistemas!"
console.log("O Length: ", text.length);

// 2° Indexof

console.log("O IndexOf: ", text.indexOf('Siac'));

// 3° Search
console.log("O Search: ", text.search('Sistemas'));

// 4° Slice | Substring
console.log("O Slice: ", text.slice(0,4));
console.log("O Substring: ", text.substring(0,4));

// 5° Replace
console.log("O Replace: ", text.replace('Bem Vindo a', 'Venha pra'));

// 6° UpperCase | LowerCase
console.log("O UpperCase: ", text.toUpperCase());
console.log("O LowerCase: ", text.toLowerCase());

// 7° Trim
var nome="   Marcus Vinicius Barros de Araujo          "
console.log("Trim: ", nome.trim());

// 8° CharAt
console.log("CharAt: ", text.charAt(1));