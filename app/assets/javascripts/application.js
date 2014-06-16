//= require jquery
//= require jquery_ujs
//= require turbolinks
<<<<<<< HEAD
//= require jquery.ui.all
//= require article.js
//= require_tree .
=======
//= require_self
// remove require_tree .

>>>>>>> 84aef86727a9f8443bd6ac6e992193f6ae8bc6d5


function populateFrontpage() {
  url = "http://www.npr.org/rss/rss.php?id=1001";
  var feedItem = loadFeed(url);
  var articleModel = new ArticleModel(feedItem);
  var articleView  = new ArticleView(articleModel);
  $('.frontpage').append(articleView.render().el);
}

$(function(){
  populateFrontpage();
})
