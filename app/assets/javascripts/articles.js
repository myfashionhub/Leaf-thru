function generateButtons() {
  var saveButton    = $('<button>').addClass('save-article').html('Save article');
  var discardButton = $('<button>').addClass('discard-article').html('Not interested');
  var buttons       = $('<div>').addClass('buttons').append(saveButton).append(discardButton);
  return buttons;
}

function saveArticle(e) {
  var article = $(e.target).parent().parent();
  console.log('Clicked');  
  var title   = article.children().first().children().html();
  var url     = article.children().first().children().attr('href');
  var extract = $(article.children()[1]).html();
  var source  = $(article.children()[2]).attr('data');
  saveArticle(title, url, extract, source);
  console.log(title);
}

