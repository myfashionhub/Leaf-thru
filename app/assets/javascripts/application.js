//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.ui.all
//= require_self
//= require_tree .

$(window).load(function() {
 
})  

$(document).ready(function() {
  $('.nav').hide();

  $('#arrow').click(function() {
    $('.nav').toggle('blind');
  })

  $('.nav').children().click(function() {
    $('.nav').hide();
  })

$('#unlink-fb').click(function() {
  $.ajax({
    url: '/readers/facebook',
    method: 'post',
    data: { reader: { facebook_token: 'nil' } },
    dataType: 'json', 
    success: function() {}
  })
})

$('#unlink-tw').click(function() {
  $.ajax({
    url: '/readers/twitter',
    method: 'post',    
    data: { reader: { twitter_token: nil, twitter_token_secret: nil } },
    dataType: 'json', 
    success: function() {}
  })  
})

})

