$(function() {
  $('.login form').submit(login);
});

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
        getLocation();
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
