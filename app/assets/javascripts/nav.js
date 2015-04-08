function dropdownMenu() {
  $('.menu #arrow').click(function() {
    $('.menu .nav').toggle('blind')
  });

  $('.menu .nav').children().click(function() {
    $('.menu .nav').removeClass('active');
  });
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

function notify(msg, status) {
  var div;
  if (status === 'success') {
    div = $('.notify');
  } else if (status === 'error') {
    div = $('.alert');
  }

  div.html(msg).fadeIn();
  setTimeout(function() {
    div.fadeOut();
  }, 3000);
}
