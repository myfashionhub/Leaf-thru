function feedItems(){
var feed = new google.feeds.Feed("http://www.npr.org/rss/rss.php?id=1001");
feed.setResultFormat(google.feeds.Feed.JSON_FORMAT);
feed.setNumEntries(1)
debugger;
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

// function ArticleCollection()
//   this.articles = {
//   }

// ArticleCollection.prototype.add = function(article){
//   var that = this;

// }


//*******View*************
function ArticleView(model){
  this.model = model;
  this.el = undefined;
}

ArticleView.prototype.render = function() {
  //var div = $('<div>');
  function populateFrontpage(result) {
    i = 0;
    for (var i = 0; i < result.feed.entries.length; i++) {
      $div = $('div').addClass('article');
      $div.append('<div class = "date">' + result.feed.entries[i].publishedDate + '</div>');
      $div.append('<a href="'+ result.feed.entries[i].link +'">' + result.feed.entries[i].title + '</a>');
      $div.append('<div class = "extract">' + result.feed.entries[i].content + '</div>');
    $('.frontpage').append($div);
    }
  this.model.feed.load(populateFrontpage);
  }

};