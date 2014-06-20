$(document).ready(function() {
  $('.signup').hide();
  $('#login').css('color', 'limegreen');
  $('.tooltip').hide();

  $('#signup').click(function() {
    $('.signup').fadeIn('slow');
    $('#signup').css('color', 'limegreen');
    $('.login').hide();
    $('#login').css('color', '#444');
  });

  $('#login').click(function() {
    $('.login').fadeIn('slow');
    $('#login').css('color', 'limegreen');
    $('.signup').hide();
    $('#signup').css('color', '#444');
  });

  $('.works').hover(
    function() {
      $('.tooltip').show().css({'position': 'absolute'});
    },
    function(){
      $('.tooltip').hide();
    }
  );

  // Profile page
  $('.subscription label:nth-child(3n+1)').append($('<br/>'));

})


;
