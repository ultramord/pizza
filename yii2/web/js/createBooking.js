"use strict";

$(document).ready(function(){
var form;
var url;
if(window.date.goods !== undefined){
	localStorage.setItem('cart', JSON.stringify(window.date.goods));
}
show(JSON.parse(localStorage.getItem('cart')) || []);
//отправка первой формы
$('form').on('beforeSubmit', function(e) {
    form = $(this);
    url = $(this).closest('form').attr('action');
    form.yiiActiveForm('data').validated = false;
	nextToSecondScreen();
}).on('submit', function(e){
    e.preventDefault();
})
//переход обратно к первой форме
$('#first-back').click(function(){
	backToFirstScreen();
})
$('#second-back').click(function(){
	backToSecondScreen();
})
$('#second-next').click(function(){
	nextToThirdScreen();
})
$('#accept').click(function(){
	var cart = JSON.parse(localStorage.getItem('cart')) || [];
	if(cart.length == 0){
		alert('Вы не добавили товаров в корзину!');
		return;
	}
	var formData = form.serialize();
	var dataArr = {
		'cart': cart, 
		'model': Qs.parse(formData),
	};
	$.ajax({
        type:'POST',      
        url: url,
        data: dataArr,
        success: function(){
        		console.log('Добавлено!');
			},
		error: function(e){
				console.error(e);
			}
    });
})
//добавление в корзину товара
$('.btn-add').click(function(){
	var id = $(this).attr('data-id');
	var name = $(this).closest('div').find('.name').text();
	var price = $(this).closest('div').find('.price').text();
	if (localStorage){
			var cart = JSON.parse(localStorage.getItem('cart')) || [];
			var i = 0; 
			for(i = 0 ; i < cart.length ; i++){
				if (cart[i].id == id){
					cart[i].count++;
					break;
				}
			}
			if (i == cart.length){
				cart.push({'id' : id, 'name' : name, 'price' : price, 'count' : 1});
			}
			localStorage.setItem('cart', JSON.stringify(cart));
	}
	show(cart);
})
// функция вывода на экран товаров

function show(cart){
	var out = '';
	var totalPrice = 0;
	var price = 0;
	for(var i = 0; i < cart.length; i++){
		out+='<tr>';
		out+='<th><p>'+cart[i].name+'</p></th>';
		out+='<th><p>'+cart[i].count+'</p></th>';
		price = cart[i].count*cart[i].price;
		totalPrice += price;
		out+='<th><p>'+price+'</p></th>';
		out+='<th><span class="glyphicon glyphicon-remove goods-remove" data-id="'+cart[i].id+'"></span></th>';
		out+='</tr>';
	}
	$('.table-goods tbody').html(out);
	$('.total-price').html('<b>Итого</b>: '+totalPrice+' рублей.');
}



// удаление товара из корзины
$(document).on('click','.goods-remove',function(){
	var id = $(this).attr('data-id');
	var cart = JSON.parse(localStorage.getItem('cart'));
	for(var i = 0; i < cart.lenght; i++){
		if(cart[i].id == id){
			cart.splice(i,1);
			break;
		}
	}
	cart.splice(0,1);
	localStorage.setItem('cart', JSON.stringify(cart));
	show(cart);
})
});

function nextToSecondScreen(){
	$('.form-1').hide();
	$('.form-2').show();
	$('.order').show();	
}

function nextToThirdScreen(){
	$('.form-2').hide();
	$('.form-3').show();
}


function backToFirstScreen(){
	$('.form-1').show();
	$('.form-2').hide();
	$('.order').hide();
}

function backToSecondScreen(){
	$('.form-2').show();
	$('.form-3').hide();
}
