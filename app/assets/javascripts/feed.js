function loadRssFeeds() {
  $.ajax({
    url: '/feeds/rss',
    type: 'GET',
    dataType: 'json',
    success: function(data) {
      $('.rss .active').removeClass('active');
      if (data.length === 0) {
        $('.no-rss').addClass('active');
      } else {
        setTimeout(function() {
          displayRssArticle(data);
        }, 300);
      }
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
    ($article).hide().prependTo($('.rss .content')).fadeIn();
  }

  articleAction();
}


function twitterFeed() {
  $.ajax({
    url     : '/feeds/twitter',
    dataType: 'json',
    success : function(data) {
      $('.twitter .active').removeClass('active');
      if (data.length === 0) {
        $('.twitter .error').addClass('active');        
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
            .prependTo($('.twitter .content'))
            .toggle('slide');
  }

  articleAction();
}


function addActionButtons() {
  var saveButton    = $('<button>').addClass('save-article');
  saveButton.html('<i class="fa fa-bookmark-o"></i> Bookmark');
  var discardButton = $('<button>').addClass('discard-article');
  discardButton.html('<i class="fa fa-trash-o"></i> Skip');
  
  var buttons = $('<div>').addClass('buttons')
  buttons.append(saveButton).append(discardButton);
  return buttons;
}

function refreshFeed(feedName) {
  if (feedName.indexOf('rss') > -1) {
    $('.rss .loader').addClass('active');
    loadRssFeeds();
  } else if (feedName.indexOf('twitter') > -1) {
    $('.twitter .loader').addClass('active');
    twitterFeed();
  }
}


function Feed() {
  this.init = function() {
    this.activeFeed();
  };

  this.activeFeed = function() {
    var activateFeed = function(tabName) {
      $('.tabs .' + tabName).addClass('active');
      $('.feed.' + tabName).addClass('active');
    };

    activateFeed('rss');
    $('.tabs li').click(function(e) {
      $('.tabs .active').removeClass('active');
      $('.feed.active').removeClass('active');
      tabName = $(e.target).attr('class');
      activateFeed(tabName);
    });

    // $('.tabs .refresh').click(function() {
    // });
  };

  this.init();
}
