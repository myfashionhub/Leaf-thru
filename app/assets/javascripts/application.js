//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function populateFrontpage() {
  // Do this for every url in the interests
  url = 'http://rss.nytimes.com/services/xml/rss/nyt/World.xml';
  var feedItem = loadFeed(url);
  var articleModel = new ArticleModel(feedItem);
  var articleView = new ArticleView(articleModel);
  articleView.render();
}


$(function(){
  populateFrontpage();
})
