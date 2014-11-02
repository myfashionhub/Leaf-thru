require 'open-uri'

module GoogleFeed

  def self.fetch_articles(feed_urls)
    GoogleAjax.api_key = ENV['LT_GOOGLE_KEY']
    GoogleAjax.referer = 'http://leafthru.nessanguyen.com'

    articles = feed_urls.map do |feed_url|
      raw = GoogleAjax::Feed.load(URI::encode(feed_url), {num: 10})

      raw[:entries].each do |entry|
        # handler for Huffpost, whose extract is too long
        if entry[:content].length > 500
          text_end = entry[:content].index(/\n/) ||
          text_end = entry[:content].index('.')
          extract = entry[:content].slice(0, text_end)
        else
          extract = entry[:content]
        end
        {
          publisher: raw[:title],
          date_published: entry[:published_date],
          url: entry[:link],
          title: entry[:title],
          extract: extract
        }
      end
    end
  end

end
