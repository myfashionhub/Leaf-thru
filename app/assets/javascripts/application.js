//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require_self
//= require_tree .

$(window).load(function() {
  $('.nav').css({
    'position': 'absolute',
    'z-index': '1',
    'right': '10px',
    'top': '60px',
    'display': 'none'
  });
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
  getPublications();
  $('.notify').hide();
  currentSubscription();
  $('#update-sub').click(updateSubscription);
  $('#update-profile').click(updateProfile);

  hideNotice(); // For pages with erb notice
})

