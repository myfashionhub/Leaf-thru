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
  var latitude, longitude;
  if (navigator.geolocation != undefined) {
    navigator.geolocation.getCurrentPosition(
      updateLocation,
      function(error) { console.log(error) },
      { timeout: 5000 }
    );
  }
}

function updateLocation(data) {
  console.log(data.coords)
  latitude = data.coords.latitude;
  longitude = data.coords.longitude;

  $.ajax({
    url: '/location',
    type: 'POST',
    data: { 'latitude': latitude, 'longitude': longitude },
    dateType: 'json',
    success: function(response) {
      console.log(response)
    },
    error: function(response) {
      //console.log(response)
    }
  });
}
