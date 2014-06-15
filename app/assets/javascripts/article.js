function loadFeed(url) {
  var feed = new google.feeds.Feed(url);
  feed.setNumEntries(3);
  feed.load(function(data){ 
    displayFeedArticle(data); 
  });
}

function displayFeedArticle(data) {
  for (var i = 0; i < data.feed.entries.length; i++) {
    var $article = $('<div>').addClass('article');
    var date     = new Date(data.feed.entries[i].publishedDate);
    var $date    = $('<div>').addClass('date').append(date);
    var $url     = $('<a>').attr('href', data.feed.entries[i].link);
    var $title   = $('<h3>').addClass('title').append(data.feed.entries[i].title);
    var $extract = $('<p>').addClass('extract').html(data.feed.entries[i].content);
    var $publisher= $('<p>').addClass('publisher').html('Published by: '+data.feed.title);
    $title.wrapInner($url);
    $extract     = $extract.contents().first();
    $article.append($title).append($extract).append($publisher);
    $('.rss-feed').append($article);
  }    
}

function rssFeed() {
  // var feed_urls = $('.rss-feed').attr('feed-data');
  var feed_urls = ['http://sports.espn.go.com/espn/rss/news'];
  for (var i = 0; i < feed_urls.length; i++) {
    loadFeed(feed_urls[i]);    
  }
}

function twitterFeed() {
  $.ajax({
    url     : '/twitter',
    dataType: 'json',
    success : function(data){
      displaySocialArticle(data);
    }
  })
}

function displaySocialArticle(data) {
  for (var i = 0; i < data.length; i++) {
    var $article = $('<div>').addClass('article');
    var $title   = $('<h3>').addClass('title').html(data[i].title);
    var $url     = $('<a>').attr('href', data[i].url);
    var $extract = $('<p>').addClass('extract').html(data[i].extract);
    var $sharedBy= $('<p>').addClass('shared-by').html('Shared by: ');
    var $sharer  = $("<a href='http://twitter.com/"+data[i].shared_by+"' >@"+data[i].shared_by+"</a>");
    $sharedBy.append($sharer);

    $title.wrapInner($url);
    $article.append($title).append($extract).append($sharedBy);
    $('.twitter-feed').append($article);
  }  
}
