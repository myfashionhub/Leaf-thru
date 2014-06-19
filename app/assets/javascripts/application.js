//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require_self
//= require_tree .

$(window).load(function() {
  $('.nav').css({ 'position': 'absolute', 'z-index': '1', 'right': '10px', 'top': '60px', 'display': 'none' });
})

$(document).ready(function() {
  // Drop down menu
  $('.nav').hide();

  $('#arrow').click(function() {
    $('.nav').toggle('blind');
  })

  $('.nav').children().click(function() {
    $('.nav').hide();
  })

  // Delete article
  $('.delete').click(function(e) {
    deleteArticle(e);
  });
})

