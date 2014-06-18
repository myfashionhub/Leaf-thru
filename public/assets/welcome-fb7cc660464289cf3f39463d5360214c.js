$(document).ready(function() {
  $('.signup').hide();

  $('#signup').click(function() {
    $('.signup').fadeIn('slow');
    $('.login').hide();
  })

  $('#login').click(function() {
    $('.login').slideDown(600);
    $('.signup').hide();
  })


  $('.nav').hide();
  $('#arrow').click(function() {
    $('.nav').toggle('blind');
  })


})


;
