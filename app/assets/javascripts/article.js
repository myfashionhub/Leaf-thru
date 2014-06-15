function loadFeed(url) {
  var feed = new google.feeds.Feed(url);
  feed.setNumEntries(3);
  feed.load(function(data){ 
    displayArticle(data); 
  });
}

function displayArticle(data) {
  for (var i = 0; i < data.feed.entries.length; i++) {
    var $article = $('<div>').addClass('article');
    var date     = new Date(data.feed.entries[i].publishedDate);
    var $date    = $('<div>').addClass('date').append(date);
    var $link    = $('<a>').attr('href', data.feed.entries[i].link);
    var $title   = $('<h3>').addClass('title').append(data.feed.entries[i].title);
    var $extract = $('<p>').addClass('extract').html(data.feed.entries[i].content);
    var $publisher= $('<p>').addClass('publisher').html('Published by: '+data.feed.title);
    $title.wrapInner($link);
    $extract     = $extract.contents().first();
    $article.append($date).append($title).append($extract).append($publisher);
    $('.rss-feed').append($article);
  }    
}

function rssFeed() {
  // var feed_urls = $('.rss-feed').attr('feed-data')
  var feed_urls = ['http://sports.espn.go.com/espn/rss/news'];
  for (var i = 0; i < feed_urls.length; i++) {
    loadFeed(feed_urls[i]);    
  }
}
