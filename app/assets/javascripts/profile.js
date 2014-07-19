function updateSubscription() {
  var checkboxes = $('input:checked');
  var pub_ids = [];
  for (var i = 0; i < checkboxes.length; i++) {
    pub_ids.push($(checkboxes[i]).val());
  }

  $.ajax({
    url: '/subscriptions',
    method: 'post',
    dataType: 'json',
    data: { pub_ids: pub_ids },
    success: function(data) {
      $('.notify').html(data['msg']);
      notify();
    }
  })
}

function currentSubscription() {
  $.ajax({
    url: '/publications',
    method: 'get',
    dataType: 'json',
    success: function(data) {
      for (i = 0; i < data.length; i++) {
        var pub = $('<li>').html(data[i].name);
        $('.current-sub ul').append(pub);
      }
    }
  });

}

function updateProfile() {
  var email    = $('#reader_email').val();
  var password = $('#reader_password').val();
  var name     = $('#reader_name').val();
  var image    = $('#reader_image').val();

  $.ajax({
    url: '/profile',
    method: 'post',
    dataType: 'json',
    data: { reader: { email: email, password: password, name: name, image: image } },
    success: function(data) {
      $('.notify').html(data['msg']);
      notify();
    }
  })
}
