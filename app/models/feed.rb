class Feed < ActiveRecord::Base
  def self.twitter(reader_id, twitter_handle)
    article_links = TwitterFeed.get_timeline(twitter_handle)

    WatsonApi.get_articles(article_links)
  end
end
