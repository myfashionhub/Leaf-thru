function articleAction() {
  $('.article button').click(function(e) {
    var article     = $(e.target).parent().parent();
    var buttonClass = $(e.target).attr('class');

    if (buttonClass === 'save-article') {
      saveArticle(article);
    }
    article.toggle('drop', 500, function(){
      article.remove();
    });
  });
}

function saveArticle(article) {
  var title   = article.find('.title').html();
  var url     = article.find('.title').attr('href');
  var extract = $(article.children()[1]).html();
  var publisher = article.find('.publisher').attr('data');
  var sharedBy  = article.find('.shared-by').attr('data');

  var article = {
    title: title,
    url: url,
    extract: extract
  };
  if (publisher) {
    article.publication = publisher;
  }
  else {
    article.shared_by = sharedBy;
  }

  $.ajax({
    url: '/articles',
    method: 'post',
    dataType: 'json',
    data: {article: article},
    success: function(data) {
      $('.notify').show().html(data['msg']);
      setTimeout(function() {
        $('.notify').fadeOut();
      }, 2000);      
    }
  })
}

function noArticle(e) {
  var feed = $(e.target).parent().parent().parent();
  if ($(feed).find('div').length === 0) {
    $(feed).append('No more article in this feed.')
           .append("<a href='/articles'>Read saved articles</a>");
  }
}

function deleteArticle(e) {
  var button = $(e.target);
  button.parent().toggle('clip', 500, function() {
    button.parent().remove();
  });
  $.ajax({
    url: button.attr('data'),
    method: 'delete',
    success: function() { }
  });
}
