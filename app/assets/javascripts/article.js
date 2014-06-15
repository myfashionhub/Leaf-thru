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
function ArticleView(model){
  this.model = model;
  this.el = undefined;
}

ArticleView.prototype.render = function(result) {
  function populateFrontpage(result) {
    for (var i = 0; i < result.feed.entries.length; i++) {
      var $article = $('<div>').addClass('article');
      var $date    = $('<div>').addClass('date').append(result.feed.entries[i].publishedDate);
      var $link    = $('<a>').attr('href', result.feed.entries[i].link);
      var $title   = $('<h3>').append(result.feed.entries[i].title);
      $title.wrapInner($link);
      var $extract = $('<p>').addClass('extract').html(result.feed.entries[i].content);
      $extract.children().last().remove();
      $article.append($date).append($title).append($extract);
      $('.frontpage').append($article);
    }
  }  
  this.model.feed.load(populateFrontpage);
  console.log(this.model);
};
