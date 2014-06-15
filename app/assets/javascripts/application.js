//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function loadFeed(url) {
  var feed = new google.feeds.Feed(url);
  feed.setNumEntries(1);
  feed.load();
  return feed;
}

//******Model*******

function ArticleModel(obj) {
  this.feed = obj;
  // this.title = result.feed.entries[0].title;
  // this.link = feed.entries[0].link;
  // this.publishedDate = feed.entries[0].publishedDate;
  // this.content = feed.entries[0].content;
}


//*******View*************
function populateFrontpage() {
  // Do this for every url in the interests
  url = "http://www.npr.org/rss/rss.php?id=1001";
  var feedItem = loadFeed(url);
  var articleModel = new ArticleModel(feedItem);
  var articleView = new ArticleView(articleModel);
  articleView.render();
}


$(function(){
  populateFrontpage();
})
