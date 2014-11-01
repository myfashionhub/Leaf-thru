module Twitter
  def self.get_feed(token, token_secret)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = token
      config.access_token_secret = token_secret
    end

    tweets = client.home_timeline(options={count: 15})
  end

  def self.collect_links(tweets)
    links = tweets.map do |tweet|
      url    = tweet.urls[0]
      if url.nil? == false
        url       = url.attrs[:expanded_url]
        shared_by = tweet.user.screen_name
        { url: url, shared_by: shared_by }
      end
    end
  end

  def self.filter_sources(links)
    links.compact.delete_if { |link| #regex domain is in?
      link[:url].empty? ||
      link[:url].include?('youtu.be') ||
      link[:url].include?('youtube.com') ||
      link[:url].include?('pinterest.com') ||
      link[:url].include?('pin.it') ||
      link[:url].include?('vimeo.com') ||
      link[:url].include?('vine.co') ||
      link[:url].include?('twitpic.com') ||
      link[:url].include?('instagram.com') ||
      link[:url].include?('login') ||
      link[:url].include?('shop')
    }
  end

end
