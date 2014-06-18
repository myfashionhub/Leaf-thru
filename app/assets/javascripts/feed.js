function rssFeed() {
  var feed_urls = $('.rss.feed').children();
  for (var i = 0; i < feed_urls.length; i++) {
    url = $(feed_urls[i]).attr('data-feed');
    loadFeed(url);
  }
}

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
    if ($url.attr('href').indexOf('nytimes') > -1) {
      $extract.html($extract.contents().first());
    } 
    var $publisher= $('<p>').addClass('publisher').attr('data', data.feed.title).html('Published by: '+data.feed.title);
    $title.wrapInner($url);
    $article.append($title).append($extract).append($publisher).append(generateButtons());
    $('.rss').append($article);
  }
  $('.rss .save-article').on('click', function(e) { 
    articleAction('.save-article', e);
  });

  $('.rss .discard-article').on('click', function(e) {
    articleAction('.discard-article', e);
  });   
}


function twitterFeed() {
  $.ajax({
    url     : '/twitter',
    dataType: 'json',
    success : function(data){
      $('#loader').hide();
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
    var $sharedBy= $('<p>').addClass('shared-by').attr('data', data[i].shared_by).html('Shared by: ');
    var $sharer  = $("<a target='_blank' href='http://twitter.com/"+data[i].shared_by+"' >@"+data[i].shared_by+"</a>");
    $sharedBy.append($sharer);

    $title.wrapInner($url);
    $article.append($title).append($extract).append($sharedBy).append(generateButtons());
    $('.twitter').append($article);
  }
  $('.twitter .save-article').on('click', function(e) { 
    articleAction('.save-article', e);
  });

  $('.twitter .discard-article').on('click', function(e) {
    articleAction('.discard-article', e);
  });  
}


function generateButtons() {
  var saveButton    = $('<button>').addClass('save-article').html('<i class="fa fa-bookmark-o"></i> Bookmark');
  var discardButton = $('<button>').addClass('discard-article').html('<i class="fa fa-trash-o"></i> Not interested');
  var buttons       = $('<div>').addClass('buttons').append(saveButton).append(discardButton);
  return buttons;
}
