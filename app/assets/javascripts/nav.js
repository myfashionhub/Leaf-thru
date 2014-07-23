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
    $('#signup').addClass('current');
    $('#login').removeClass('current');
    $('.login').hide();
  });

  $('#login').click(function() {
    $('.login').fadeIn('slow');
    $('.signup').hide();
    $('#login').addClass('current');
    $('#signup').removeClass('current');
  });
}

function notify() {
  $('.notify').fadeIn();
  setTimeout(function() {
    $('.notify').fadeOut();
  }, 3000);
}

function hideNotice() {
  if ($('.notice').html() != '') {
    setTimeout(function() {
      $('.notice').fadeOut();
    }, 3000);
  }
}
