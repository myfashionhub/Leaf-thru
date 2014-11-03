require 'open-uri'

module GoogleFeed

  def self.fetch_articles(feed_urls)
    GoogleAjax.api_key = ENV['LT_GOOGLE_KEY']
    GoogleAjax.referer = 'http://leafthru.nessanguyen.com'
    articles = []

    feed_urls.each do |feed_url|
      feed = GoogleAjax::Feed.load(URI::encode(feed_url), {num: 10})
      publisher = feed[:description]

      feed[:entries].each do |entry|
        if entry[:content].length > 500
          extract = entry[:content_snippet]
        else
          extract = entry[:content]
        end
        articles.push({
          publisher: publisher,
          title: entry[:title],
          url: entry[:link],
          date_published: entry[:published_date],
          extract: extract
        })
      end
    end

    return articles
  end

end
