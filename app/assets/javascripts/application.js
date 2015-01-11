//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require_self
//= require_tree .

$(document).ready(function() {
  // Navigation
  loginToggle();
  dropdownMenu();
  howItWorks();

  // News feed
  $('.feed .fa-refresh').click(function(e) {
    var feed = $(e.target).parent().parent();
    console.log(feed);
    refreshFeed(feed.attr('class'))
  });

  // Delete article
  $('.delete').click(function(e) {
    deleteArticle(e);
  });

  // Profile page
  getPublications();
  currentSubscription();
  $('#update-sub').click(updateSubscription);
  $('#update-profile').click(updateProfile);

});

