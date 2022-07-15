class Feed < ActiveRecord::Base
  def self.twitter(reader_id, twitter_handle)
    article_links = TwitterFeed.get_timeline(twitter_handle)

    articles = Alchemy.get_articles(article_links)
    articles && articles.length > 0 ? articles : []
  end
end
