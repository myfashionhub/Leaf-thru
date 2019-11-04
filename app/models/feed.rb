require "#{Rails.root}/lib/alchemy"
require "#{Rails.root}/lib/twitter"

class Feed < ActiveRecord::Base
  def self.twitter(reader_id, token, token_secret)
    article_links = Rails.cache.fetch(
      "/#{reader_id}/twitter/urls", expires_in: 2.hours
    ) do
      Twitter::Feed.new(token, token_secret).get_timeline
    end

    articles = Alchemy.get_articles(article_links)
    articles && articles.length > 0 ? articles : []
  end
end
