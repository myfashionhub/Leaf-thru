function toggleForm(formSelector) {
  $('.form')
  var display = $(formSelector).attr('display');
  if (display === 'none') {
    display = '';
  } else {
    display = 'none';
  }
}

$(window).load(function() {
  $('#choose').html('Sign up');
  $('.signup').hide();

  $('#choose').click({
    toggleForm('.signup');
    toggleForm('.login');
  })   
})


