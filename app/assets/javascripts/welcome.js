function toggleForm(formSelector) {
  $('.form')
  var display = $(formSelector).attr('display');
  if (display === 'none') {
    display = 'block';
  } else {
    display = 'none';
  }
}

$(window).load(function() {
  $('.signup').hide();
  //$('.login').hide();

  $('#signup').click(function() {
    $('.signup').toggle('drop', 600);
    $('.login').hide();
  }) 

  $('#login').click(function() {
    $('.login').toggle('drop', 600);
    $('.signup').hide();
  })     
})


