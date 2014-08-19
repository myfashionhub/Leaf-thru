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
      alreadySaved(data);
    }
  })
}

function alreadySaved(data) {
  if (data['msg'] === "Already saved!") {
    $('.notice').show().html(data['msg']);
  } else {
    $('.notice').show().html('Successfully save article');
  }
  setTimeout(function() {
    $('.notice').fadeOut();
  }, 3000);
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

function deleteComma() {

}
