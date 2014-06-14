function feedItems(){
var feed = new google.feeds.Feed("http://www.npr.org/rss/rss.php?id=1001");
feed.setResultFormat(google.feeds.Feed.JSON_FORMAT);
feed.setNumEntries(1)
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

ArticleView.prototype.render = function() {
  //var div = $('<div>');
  function populateFrontpage(result) {
    i = 0;
    for (var i = 0; i < result.feed.entries.length; i++) {
      $div = $('div').addClass('article');
      $div.append('<div class = "date">' + result.feed.entries[i].publishedDate + '</div>');
      $div.append('<a href="'+ result.feed.entries[i].link +'">' + result.feed.entries[i].title + '</a>');
      $div.append('<div class = "extract">' + result.feed.entries[i].content + '</div>');
      $button = $('<button>').addClass('save_article');
      $button.html("Save Article");
      $div.append($button);
      $('.frontpage').append($div);

    }
  }
  this.model.feed.load(populateFrontpage);
};


//***********Collection*************

 function ArticlesCollection(){
  this.models = {};//empty object...object literal???
  }

ArticlesCollection.prototype.add = function(article){
  var newArticle = new Article(articleJSON);//what is this? where does it come from.
  this.models[articleJSON.id] = newArticle;
  $(this).trigger('addFlare');
  return this;
}

ArticlesCollection.prototype.create = function(paramObject){
  var that = this;
  $.ajax({
    url: '/articles',
    method: 'post',
    dataType: 'json',
    data: {article: paramObject},
    success: function(data){
      that.add(data);
    }
  })
}

ArticlesCollection.prototype.fetch = function(){
  var that = this;
  $.ajax({
    url: '/articles',
    dataType: 'json',
    success: function(data){
      for (idx in data){
        that.add(data[idx]);
      }
    }
  })
};

var articlesCollection = new ArticlesCollection();

$('.save_article').on('click', function(e){
  //e.preventDefault();
  console.log("clicky");
  // var newArticle = $('.article').title();
  // ArticleCollection.create({article/params})
})

