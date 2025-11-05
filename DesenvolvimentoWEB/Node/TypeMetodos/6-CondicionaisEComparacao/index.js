/* 1 - IF, Else e If Else
   2 - Switch
   3 - Operadores de Comparação
            == ou ===
            ==/ ou ===/
            > ou <
            >= ou <=
            ? Operador Ternario
    4 - Operadores Logicos
            $$ || !
*/

const pessoasArray = [
  {
    nome: 'Marcus',
    idade: 31,
    sexo :'M'
  },
  {
    nome: 'Aline',
    idade: 30,
    sexo :'F'
  },
  {
    nome: 'Maria clara',
    idade: 11,
    sexo :'F'
  },
  {
    nome: 'Samuel',
    idade: 8,
    sexo :'M'
  }
]


 // 1 - IF

pessoasArray.forEach(p =>
  {
  if(p.nome === 'Samuel')
  {
    console.log('Deu certo!')
  }else
    console.log('Não encontrei!')

})










