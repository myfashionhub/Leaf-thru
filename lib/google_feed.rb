require 'open-uri'

module GoogleFeed

  def self.fetch_articles(feed_urls)
    GoogleAjax.api_key = ENV['LT_GOOGLE_KEY']
    GoogleAjax.referer = 'http://leafthru.nessanguyen.com'
    articles = []

    feed_urls.each do |feed_url|
      feed = GoogleAjax::Feed.load(URI::encode(feed_url), {num: 5})

      feed[:entries].map do |entry|
        extract = entry[:content].length > 500 ?
                    entry[:content_snippet] : entry[:content]

        articles.push({
          publisher: feed[:title] || feed[:description],
          title: entry[:title],
          url: entry[:link],
          date_published: entry[:published_date],
          extract: extract
        })
      end
    end

    articles
  end

end
