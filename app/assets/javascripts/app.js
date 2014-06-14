

function populateFrontpage () {
  var articleModel = new ArticleModel(feedItems());
  debugger;
  var articleView = new ArticleView(articleModel);
  //$('.frontpage').append(articleView.render());
  articleView.render()
}

// function setEventHandlers(){
//   populateFrontpage()
// }

$(function(){
  populateFrontpage();
})
