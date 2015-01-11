$(function() {
  $('.signup form').submit(signup);
  getLocation();
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

function getLocation() {
  if (navigator.geolocation != undefined) {
    navigator.geolocation.getCurrentPosition(function(data) {
      console.log(data)
    });
  }
}
