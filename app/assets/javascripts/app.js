var articleCollection = new ArticleCollection();

function populateFrontpage () {
  var articleModel = new ArticleModel(feedItems());
  var articleView = new ArticleView(articleModel);
  saveArticle();
  articleView.render();
}

function saveArticle(result){
  var article = new ArticleModel({url: result});
  articleCollection.add(article);
}

$(function(){
  populateFrontpage();
})
