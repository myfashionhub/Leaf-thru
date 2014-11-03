function loadRssFeeds() {
  $.ajax({
    url: '/rss',
    type: 'GET',
    dataType: 'json',
    success: function(data) {
      $('.rss .content').children().fadeOut('slow').remove();
      setTimeout(function() {
        displayRssArticle(data);
      }, 300);
    }
  });
}

function displayRssArticle(entries) {
  for (var i = 0; i < entries.length; i++) {
    var entry    = entries[i];
    var $publisher = $('<p>').addClass('publisher')
                            .attr('data', entry.publisher)
                            .html('Published by: '+ entry.publisher);
    var $article = $('<div>').addClass('article');
    var $date    = $('<div>').addClass('date')
                             .append(new Date(entry.date_published));
    var $url     = $('<a>').attr('href', entry.url).attr('target', '_blank');
    var $title   = $('<h3>').addClass('title')
                            .html(entry.title);
    var $extract = $('<p>').addClass('extract')
                           .html(entry.extract);
    $title.wrapInner($url);
    $article.append($title)
            .append($extract)
            .append($publisher)
            .append(addActionButtons());
    ($article).hide().appendTo($('.rss .content')).fadeIn();
  }

  articleAction();
}


function twitterFeed() {
  $.ajax({
    url     : '/twitter',
    dataType: 'json',
    success : function(data){
      $('.twitter .content').children().fadeOut('slow').remove();
      setTimeout(function() {
        if (data['msg'] === "No data") {
          var msg = "<a href='/profile'><b>Connect your Twitter account</b></a> to get updates.";
          $('.twitter .content').append(msg).hide().fadeIn();
        } else {
          displaySocialArticle(data);
        }
      }, 300);
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log(errorThrown);
      $('.twitter .content').children().fadeOut('slow').remove();
      $('.twitter .content').append('<p>Unable to obtain articles at this time.</p>')
                   .hide().fadeIn();
    }
  });
}

function displaySocialArticle(data) {
  for (var i = 0; i < data.length; i++) {
    var $article = $('<div>').addClass('article');
    var $title   = $('<h3>').addClass('title')
                            .html(data[i].title);
    var $url     = $('<a>').attr('href', data[i].url).attr('target', '_blank');
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
            .append(addActionButtons());
    $article.hide()
            .appendTo($('.twitter .content'))
            .toggle('slide');
  }

  articleAction();
}


function addActionButtons() {
  var saveButton    = $('<button>').addClass('save-article')
                                   .html('<i class="fa fa-bookmark-o"></i> Bookmark');
  var discardButton = $('<button>').addClass('discard-article')
                                   .html('<i class="fa fa-trash-o"></i> Not interested');
  var buttons       = $('<div>').addClass('buttons')
                                .append(saveButton)
                                .append(discardButton);
  return buttons;
}

function refreshFeed(feedName) {
  if (feedName.indexOf('rss') > -1) {
    loadRssFeeds();
  } else if (feedName.indexOf('twitter') > -1) {
    twitterFeed();
  }
}
