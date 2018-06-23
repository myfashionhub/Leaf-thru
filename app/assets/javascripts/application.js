//= require_self
//= require_tree .

// This waits for jQuery to load
$(document).ready(function() {
  // Navigation
  loginToggle();
  initDropdownMenu();

  // Add event listeners to forms
  $('.login form').submit(login);
  $('.signup form').submit(signup);

  $('.delete').click(function(e) {
    deleteArticle(e);
  });

  // News feed
  $('.feed .fa-refresh').click(function(e) {
    var feed = $(e.target).parent().parent();
    refreshFeed(feed.attr('class'))
  });

  window.profileDialog = new Dialog($('.dialog.profile'));
});
