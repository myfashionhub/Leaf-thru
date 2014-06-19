//= require feed

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
  if ($('.rss').children().length === 0) {
    $('.twitter').append('No more article in this feed.').append("<a href='/articles'>Read saved articles</a>");
  }
  if ($('.twitter').children().length === 0) {
    $('.twitter').append('No more article in this feed.').append("<a href='/articles'>Read saved articles</a>");
  }
}

function deleteArticle(e) {
  var button = $(e.target);
  button.parent().toggle('clip');
  $.ajax({
    url: button.attr('data'),
    method: 'delete',
    success: function() {
      button.parent().remove();
    }
  });
}

function deleteComma() {

}
