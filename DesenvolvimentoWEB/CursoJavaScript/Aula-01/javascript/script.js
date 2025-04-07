function mensagem(name){
    alert(name + " - Vc clicou no botão!");
}

function mudaCor(cor){
    var elemento = document.getElementById("texto");
    elemento.style.color = cor;
}


function validaForm(){
    var nomeEste = document.getElementById('nomeDigitado');
    
    if(nomeEste.value == ""){
        alert("Campo nome VAZIO!")
    }else{
    alert(nomeEste.value + " Deu certo ");
}
}