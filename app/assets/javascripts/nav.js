function dropdownMenu() {
  $('.nav').hide();

  $('#arrow').click(function() {
    $('.nav').toggle('blind');
  });

  $('.nav').children().click(function() {
    $('.nav').hide();
  });
}

function howItWorks() {
  $('.tooltip').hide();

  $('.works').hover(
    function() {
      $('.tooltip').show();
    },
    function() {
      $('.tooltip').hide();
    }
  );
}

function loginToggle() {
  $('.signup').hide();
  $('#login').addClass('current');

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
}

function notify() {
  $('.notify').fadeIn();
  setTimeout(function() {
    $('.notify').fadeOut();
  },2000);
}
