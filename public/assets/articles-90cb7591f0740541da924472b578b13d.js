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
;

function articleAction(buttonSelector, e) {
  if (buttonSelector === '.save-article') {
    saveArticle(e);      
  }
  var article = $(e.target).parent().parent(); 
  article.toggle('drop', 500, function(){ article.remove(); });
}

function saveArticle(e) { 
  var article = $(e.target).parent().parent(); 
  var title   = article.children().first().children().html();
  var url     = article.children().first().children().attr('href');
  var extract = $(article.children()[1]).html();
  var source  = $(article.children()[2]);
  var publication = undefined;
  var shared_by   = undefined;
  if (source.text().indexOf('Published') > -1 === false) {
    shared_by   = source.attr('data');

  } else { 
    publication = source.attr('data');
  }

  $.ajax({
    url: '/articles',
    method: 'post',
    dataType: 'json',
    data: { article: {title: title, url: url, extract: extract, publication: publication, shared_by: shared_by} },    
    success: function(data) {
      console.log('saving');
    }
  })
}

function noArticle() {
  if ($('.rss').children() === 0) {
    $('.twitter').append('No more article in this feed.').append("<a href='/articles'>Read saved articles ></a>");
  } 
  if ($('.twitter').children() === 0) {
    $('.twitter').append('No more article in this feed.').append("<a href='/articles'>Read saved articles ></a>");
  }
}
;
