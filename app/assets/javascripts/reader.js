$(function() {
  $('.signup form').submit(signup);
  //getLocation();
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
        updateLocation();
      }
    },
    error: function(response) {
      //console.log(response)
    }
  });
}

function getLocation() {
  var latitude, longitude;
  if (navigator.geolocation != undefined) {
    navigator.geolocation.getCurrentPosition(
      function(data) {
        console.log(data.coords)
        latitude = data.coords.latitude;
        longitude = data.coords.longitude;
        updateLocation(latitude, longitude);
      },
      function(error) { console.log(error) },
      { timeout: 5000 }
    );
  }
}

function updateLocation() {
  $.ajax({
    url: '/location',
    type: 'GET',
    success: function(response) {
      console.log(response)
    },
    error: function(response) {
      //console.log(response)
    }
  });
}
