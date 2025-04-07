/* primeiro jeito de se fazer */
/*
$(document).ready(function (){
    $('button').click(function(){
        $('h1').hide();
    })  ;
}); */

/* Versão reduzida do passo acima */ 
/*
$(function(){
    $('button').click(function(){
        $('h1').hide();
    });
});
*/


$(function(){
    $('#btn-1').click(function(){
        $('h1').hide();
    });
});

$(function(){
    $('#btn-2').click(function(){
        $('h2').css("color", "red");
    });
});

$(function(){
    $('#azul').click(function(){
        $('p').css("background-color", "blue");
        $('p').fadeOut();
        $('p').delay(1000);
        $('p').fadeIn();
    });

    $('#vermelho').click(function(){
        $('p').css("background-color", "red")
    });

});