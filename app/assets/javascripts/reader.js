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
        window.location.replace('/feed');
        updateLocation();
      }
    },
    error: function(response) {
      //console.log(response)
    }
  });
}


function updateLocation() {
  $.ajax({
    url: '/profile',
    type: 'POST',
    data: { 'reader': { 'update_location': true } },
    success: function(response) {
      $('.location small').html(response);
    },
    error: function(response) {
      console.log(response)
    }
  });
}

$('#update-profile').click(updateProfile);

function updateProfile() {
  var email    = $('#reader_email').val();
  var password = $('#reader_password').val();
  // var new_password = $('#reader_new_password').val();
  var name     = $('#reader_name').val();
  var image    = $('#reader_image').val();

  $.ajax({
    url: '/profile',
    method: 'post',
    dataType: 'json',
    data: { reader: { email: email,
                      password: password,
                      name: name,
                      image: image
                    }
          },
    success: function(data) {
      notify(data['msg'], 'success');
    }
  })
}
