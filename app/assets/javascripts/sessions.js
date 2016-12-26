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
        updateLocation();
        window.location.replace('/feed');
      } else if (response.status === 'error') {
        notify(response.msg, 'error');
      }
    },
    error: function(response) {
      // console.log(response)
    }
  });
}

function Session() {
  var that = this;

  this.init = function() {
    $('.social .disconnect').click(function(e) {
      e.preventDefault();
      var service = $(e.target).attr('data-service');
      that.disconnect(service);
    });
  };

  this.disconnect = function(service) {
    $.ajax({
      url: '/disconnect/' + service,
      type: 'GET',
      success: function(response) {
        $('.notify').show().html(response['msg']);
        setTimeout(function() {
          $('.notify').fadeOut();
          location.reload();
        }, 2000);
      },
      error: function(error) {}
    });
  };

  this.init();
}
