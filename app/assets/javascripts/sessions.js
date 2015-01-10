$(function() {
  $('.signup form').submit(signup);
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
        $(window).load(function() {
          notify(response.msg, 'success');
        });
      }
    },
    error: function(response) {
      //console.log(response)
    }
  });
}
