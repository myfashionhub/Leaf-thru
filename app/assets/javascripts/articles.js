function generateButtons() {
  var saveButton    = $('<button>').addClass('save-article').html('Save article');
  var discardButton = $('<button>').addClass('discard-article').html('Not interested');
  var buttons       = $('<div>').addClass('buttons').append(saveButton).append(discardButton);
  return buttons;
}

function articleAction() {
  $('.save-article').on('click', function(e) {
    var article = $(e.target).parent().parent();
    var title   = article.children().first().children().html();
    var url     = article.children().first().children().attr('href');
    var source  = $(article.children()[1]).attr('data');
    console.log(article);
  })
}
