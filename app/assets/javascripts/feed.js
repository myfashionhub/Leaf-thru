function loadRssFeeds() {
  $.ajax({
    url: '/rss',
    type: 'GET',
    dataType: 'json',
    success: function(data) {
      $('#loader').fadeOut(500).remove();
      displayRssArticle(data);
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
    var $url     = $('<a>').attr('href', entry.link).attr('target', '_blank');
    var $title   = $('<h3>').addClass('title')
                            .html(entry.title);
    var $extract = $('<p>').addClass('extract')
                           .html(entry.extract);
    $title.wrapInner($url);
    $article.append($title)
            .append($extract)
            .append($publisher)
            .append(generateButtons());
    ($article).hide().appendTo($('.rss')).fadeIn();
  }

  articleAction();
}


function twitterFeed() {
  $.ajax({
    url     : '/twitter',
    dataType: 'json',
    success : function(data){
      $('#loader').fadeOut(500).remove();
      if (data['msg'] === "No data") {
        $('.twitter').append("<a href='/profile'><b>Connect your Twitter account</b></a> to get updates.")
                      .hide().fadeIn();
      } else {
        displaySocialArticle(data);
      }
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log(errorThrown);
      $('#loader').fadeOut(500).remove();
      $('.twitter').append('<p>Unable to obtain articles at this time.</p>')
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
            .append(generateButtons());
    $article.hide()
            .appendTo($('.twitter'))
            .toggle('slide');
  }

  articleAction();
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
