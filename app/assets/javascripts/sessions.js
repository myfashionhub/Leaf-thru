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
    data: { reader: {email: email, password: password} },
    dateType: 'json',
    success: function(response) {
      notify(response.msg, response.status)
      console.log(response)
    },
    error: function(response) {
      console.log(response)
    }
  });
}
