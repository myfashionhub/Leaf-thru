//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require_self
//= require_tree .

$(window).load(function() {

})

$(document).ready(function() {
  // Drop down menu
  $('.nav').hide();

  $('#arrow').click(function() {
    $('.nav').toggle('show');
  })

  $('.nav').children().click(function() {
    $('.nav').hide();
  })

  // Delete article
  $('.delete').click(function(e) {
    deleteArticle(e);
  });
})

