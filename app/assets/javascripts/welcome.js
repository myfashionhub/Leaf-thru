
$(document).ready(function() {
  $('.signup').hide();
  //$('.login').hide();

  $('#signup').click(function() {
    $('.signup').toggle('drop', 600);
    $('.login').hide();
  }) 

  $('#login').click(function() {
    $('.login').toggle('drop', 600);
    $('.signup').hide();
  })     
})

