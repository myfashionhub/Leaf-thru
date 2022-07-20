function twitterFeed() {
  $.ajax({
    url     : '/feeds/twitter',
    dataType: 'json',
    success : function(data) {
      $('.twitter .active').removeClass('active');

      if (data.message) {
        $('.twitter .error').html(data.message).addClass('active');
      } else {
        setTimeout(function() {
            displaySocialArticle(data);
        }, 300);
      }
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log(errorThrown);
      $('.twitter .error').addClass('active');
    }
  });
}

function displaySocialArticle(data) {
  $('.feed.rss .twitter').empty();

  for (var i = 0; i < data.length; i++) {
    var $article = $('<div>').addClass('article');
    var $title   = $('<a>').attr('href', data[i].url).attr('target', '_blank')
                     .addClass('title').html(data[i].title);
    var $extract = $('<p>').addClass('extract')
                           .html(data[i].extract);
    var $author  = $('<p>').addClass('shared-by').attr('data', data[i].author)
                      .html(`Authored by ${data[i].author}`);

    $article.append($title)
            .append($extract)
            .append($author)
            .append(addActionButtons());
    $article.hide()
            .prependTo($('.twitter .content'))
            .toggle('slide');
  }

  articleAction();
}

function addActionButtons() {
  var saveButton    = $('<button>').addClass('save-article');
  saveButton.html('<i class="fa fa-bookmark-o"></i> <span>Bookmark<span/>');
  var discardButton = $('<button>').addClass('discard-article');
  discardButton.html('<i class="fa fa-trash-o"></i> <span>Skip</span>');
  
  var buttons = $('<div>').addClass('buttons')
  buttons.append(discardButton).append(saveButton);
  return buttons;
}

function refreshFeed(feedName) {
  if (feedName.indexOf('rss') > -1) {
    $('.rss .loader').addClass('active');
    // loadRssFeeds();
  } else if (feedName.indexOf('twitter') > -1) {
    $('.twitter .loader').addClass('active');
    twitterFeed();
  }
}
