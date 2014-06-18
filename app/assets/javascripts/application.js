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
})



