require "#{Rails.root}/lib/twitter"

class Feed < ActiveRecord::Base

  def self.twitter(token, token_secret)
    article_links = Twitter::Feed.new(token, token_secret).get_timeline
    articles = Alchemy.get_articles(article_links)
    articles.length > 0 ? articles : nil
  end

  def self.rss(subscriptions)
    feed_urls = subscriptions.map do |subscription|
      subscription.publication.url
    end
    GoogleFeed.fetch_articles(feed_urls)
  end

end
