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
  
  $('.form-wrapper span').click(function(e) {
    $('.current').removeClass('current');
    $(e.target).addClass('current');
    var action = $(e.target).attr('id');

    $('.form div').hide();
    $('.'+action).fadeIn('slow');
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
