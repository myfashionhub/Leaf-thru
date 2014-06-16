<<<<<<< HEAD
=======

function loadFeed(url) {
  var feed = new google.feeds.Feed(url);
  feed.setResultFormat(google.feeds.Feed.JSON_FORMAT);
  feed.setNumEntries(1)
  return feed;
}

//******Model*******

function ArticleModel(obj) {
  this.feed = obj;
}


//*******View*************
>>>>>>> e367bc11acbc39a7bd7d8f4c99ac1b959de8c127
function ArticleView(model){
  this.model = model;
  this.el = undefined;
}

<<<<<<< HEAD
ArticleView.prototype.render = function(result) {
  function aFunc(result) {
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

  this.model.feed.load(aFunc);
  console.log(this.model);
};
=======

ArticleView.prototype.render = function(result) {
  for (var i = 0; i < result.feed.entries.length; i++) {
    var $div = $('<div>');
    $div = $('div').addClass('article')
    $div.append('<div class="date">' + result.feed.entries[i].publishedDate + '</div>');
    $div.append('<a href="'+ result.feed.entries[i].link +'">' + result.feed.entries[i].title + '</a>');
    $div.append('<div class="extract">' + result.feed.entries[i].content + '</div>');
  }
  this.model.feed.load(populateFrontpage);
  this.el = $div;
  return this;
};


$('.save_article').on('click', function(e){
  e.preventDefault();
  console.log('Hello!!!!')
  saveArticle(this.article);
  // var newArticle = $('.article').title();
  // ArticleCollection.create({article/params})
});


//***********Collection*************

 function ArticleCollection(){
  this.models = {};//empty object...object literal???
  }

ArticleCollection.prototype.add = function(article){
   var that = this;
  $.ajax({
    url: '/articles',
    method: 'post',
    dataType: 'json',
    data: {article: article},
    success: function(data){
      var article = new ArticleModel(data);
      that.articles[article.id] = article;
      $(that).trigger('save');
    }
  })
}


// ArticlesCollection.prototype.create = function(paramObject){
//   var that = this;
//   $.ajax({
//     url: '/articles',
//     method: 'post',
//     dataType: 'json',
//     data: {article: paramObject},
//     success: function(data){
//       that.add(data);
//     }
//   })
// }

ArticleCollection.prototype.fetch = function(){
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



>>>>>>> e367bc11acbc39a7bd7d8f4c99ac1b959de8c127
