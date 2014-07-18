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
