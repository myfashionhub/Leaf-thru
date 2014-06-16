//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.ui.all
//= require article.js
//= require_tree .


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
