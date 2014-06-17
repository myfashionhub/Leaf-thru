$(document).ready(function() {
  $('.signup').hide();
  //$('.login').hide();

  $('#signup').click(function() {
    $('.signup').fadeIn();
    $('.login').hide();
  })

  $('#login').click(function() {
    $('.login').slideDown();
    $('.signup').hide();
  })

$('.nav').hide();
$('#arrow').click(function) {
  $('.nav').toggle();
}

})


