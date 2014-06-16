$(window).load(function() {
  $('.save-article').on('click', function(e) { 
    saveArticle(e);
    articleAction('.save-article');
  })

  $('.discard-article').on('click', function(e) {
    articleAction('.discard-article');
  })      
})

function articleAction(buttonSelector) {
  $(buttonSelector).on('click', function(e) {
    if (buttonSelector === '.save-article') {
      saveArticle(e);      
    }
    var article = $(e.target).parent().parent(); 
    article.toggle('drop', 500, function(){ article.remove(); });
    });         
}

function saveArticle(e) { 
  var article = $(e.target).parent().parent(); 
  var title   = article.children().first().children().html();
  var url     = article.children().first().children().attr('href');
  var extract = $(article.children()[1]).html();
  var source  = $(article.children()[2]).attr('data');

  $.ajax({
    url: '/articles',
    method: 'post',
    dataType: 'json',
    data: { article: {title: title, url: url, extract: extract, publication: source} },    
    success: function(data) {
      console.log('saving');
    }
  })
}
