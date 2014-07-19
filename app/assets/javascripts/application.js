//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require_self
//= require_tree .

$(window).load(function() {
  $('.nav').css({ 'position': 'absolute', 'z-index': '1', 'right': '10px', 'top': '60px', 'display': 'none' });
})

$(document).ready(function() {
  loginToggle();
  dropdownMenu();
  howItWorks();

  // Delete article
  $('.delete').click(function(e) {
    deleteArticle(e);
  });

  // Profile page
  $('.subscription label:nth-child(3n+1)').append($('<br/>'));
  $('.notify').hide();
  currentSubscription();
})

