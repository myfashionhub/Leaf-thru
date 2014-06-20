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
    var entry    = data.feed.entries[i];
    var $article = $('<div>').addClass('article');
    var $date    = $('<div>').addClass('date')
                             .append(new Date(entry.publishedDate));
    var $url     = $('<a>').attr('href', entry.link);
    var $title   = $('<h3>').addClass('title')
                            .html(entry.title);
    var $extract = $('<p>').addClass('extract')
                           .html(entry.content);

    if ($url.attr('href').indexOf('nytimes') > -1 ||
        $url.attr('href').indexOf('guardian') > -1) {
      $extract.html($extract.contents().first());
    }

    var $publisher = $('<p>').addClass('publisher')
                            .attr('data', data.feed.title)
                            .html('Published by: '+data.feed.title);
    $title.wrapInner($url);
    $article.append($title)
            .append($extract)
            .append($publisher)
            .append(generateButtons());
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
      $('#loader').fadeOut(500).remove();
      console.log(data);
      if (data['msg'] === "No data") {
        $('.twitter').append("<a href='/profile'><b>Connect your Twitter account</b></a> to get updates.")
                      .hide().fadeIn();
      } else {
        displaySocialArticle(data);
      }
    }
  })
}

function displaySocialArticle(data) {
  for (var i = 0; i < data.length; i++) {
    var $article = $('<div>').addClass('article');
    var $title   = $('<h3>').addClass('title')
                            .html(data[i].title);
    var $url     = $('<a>').attr('href', data[i].url);
    var $extract = $('<p>').addClass('extract')
                           .html(data[i].extract);
    var $sharedBy= $('<p>').addClass('shared-by')
                           .attr('data', data[i].shared_by)
                           .html('Shared by: ');
    var sharer   = "@"+data[i].shared_by;
    var sharerUrl= $('<a>').attr('href', 'http://twitter.com/'
                            +data[i].shared_by);
    sharerUrl.html(sharer).appendTo($sharedBy);
    $title.wrapInner($url);

    $article.append($title)
            .append($extract)
            .append($sharedBy)
            .append(generateButtons());
    $article.hide()
            .appendTo($('.twitter'))
            .toggle('slide');
  }
  $('.twitter .save-article').on('click', function(e) {
    articleAction('.save-article', e);
  });

  $('.twitter .discard-article').on('click', function(e) {
    articleAction('.discard-article', e);
  });
}


function generateButtons() {
  var saveButton    = $('<button>').addClass('save-article')
                                   .html('<i class="fa fa-bookmark-o"></i> Bookmark');
  var discardButton = $('<button>').addClass('discard-article')
                                   .html('<i class="fa fa-trash-o"></i> Not interested');
  var buttons       = $('<div>').addClass('buttons')
                                .append(saveButton)
                                .append(discardButton);
  return buttons;
}
