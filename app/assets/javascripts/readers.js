//= require feed
//= require articles

$(function(){
  rssFeed();
  twitterFeed();
  $('.save-article').on('click', function(e) { 
    saveArticle(e);
    console.log('click');
  })

})

