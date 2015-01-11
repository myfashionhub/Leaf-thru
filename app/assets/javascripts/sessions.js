$(function() {
  $('.signup form').submit(signup);
  $('.login form').submit(login);
});

function signup(e) {
  e.preventDefault();
  var email = $('.signup #reader_email').val(),
      password = $('.signup #reader_password').val();

  $.ajax({
    url: '/readers',
    type: 'POST',
    data: {reader: {email: email, password: password}},
    dateType: 'json',
    success: function(response) {
      if (response.status === 'error') {
        notify(response.msg, 'error')
      } else {
        window.location.replace('/subscription');
      }
    },
    error: function(response) {
      //console.log(response)
    }
  });
}

function login(e) {
  e.preventDefault();
  var email = $('.login #email').val(),
      password = $('.login #password').val();
  $.ajax({
    url: '/sessions',
    type: 'POST',
    data: { email: email, password: password },
    dateType: 'json',
    success: function(response) {
      if (response.status === 'success') {
        window.location.replace('/profile');
      } else if (response.status === 'error') {
        notify(response.msg, 'error');
      }
    },
    error: function(response) {
      // console.log(response)
    }
  });
}
