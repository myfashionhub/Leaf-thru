//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.ui.all
//= require_self
//= require_tree .

$(window).load(function() {
 
})  

$(document).ready(function() {
  $('.nav').hide();

  $('#arrow').click(function() {
    $('.nav').toggle('blind');
  })

  $('.nav').children().click(function() {
    $('.nav').hide();
  })
})


function unlinkFb() {
  $.ajax({
    url: '/logout/facebook',
    method: 'post',
    dataType: 'json', 
    success: function() {
      $('.notify').html("<%= flash[:notice] %>");
      setTimeout(function() {
        $('.notify').empty();
      }, 400);      
    }
  });
}

function unlinkTw() {
  $.ajax({
    url: '/logout/twitter',
    method: 'post',    
    dataType: 'json', 
    success: function() {
      $('.notify').html("<%= flash[:notice] %>");
      setTimeout(function() {
        $('.notify').fadeOut().remove();
      }, 120);
    }
  });  
}
