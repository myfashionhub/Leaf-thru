$(document).ready(function() {
  $('.signup').hide();
  $('#login').css('color', 'limegreen');

  $('#signup').click(function() {
    $('.signup').fadeIn('slow');
    $('#signup').css('color', 'limegreen');
    $('.login').hide();
    $('#login').css('color', '#444');
  })

  $('#login').click(function() {
    $('.login').fadeIn('slow');
    $('#login').css('color', 'limegreen');    
    $('.signup').hide();
    $('#signup').css('color', '#444');    
  }) 
  
  // Profile page
  $('.subscription label:nth-child(3n+1)').append($('<br/>'));

})

$(document).on('page:load', function() {
  $('.signup').hide();
  $('#login').css('color', 'limegreen');
})


;
