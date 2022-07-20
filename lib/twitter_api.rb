module TwitterApi
  NUM_RESULTS = 20

  def self.token
    @token ||= begin
      uri = URI('https://api.twitter.com/oauth2/token')
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(uri.path.concat('?grant_type=client_credentials'))
      request.basic_auth(ENV['LT_TWITTER_KEY'], ENV['LT_TWITTER_SECRET'])

      resp = https.request(request)
      JSON.parse(resp.body)['access_token']
    end
  end

  def self.search_twitter_api(url, query_string)
    uri = URI(url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(uri.path.concat(query_string))
    request['Authorization'] = "Bearer #{self.token}"
    request['Accept'] = 'application/json'
    request['ContentType'] = 'application/json'

    resp = https.request(request)
    JSON.parse(resp.body)
  end

  def self.get_profile(username)
    self.search_twitter_api(
      'https://api.twitter.com/1.1/users/show.json',
      "?screen_name=#{username}"
    )
  end

  def self.get_timeline(username, num_results=NUM_RESULTS)
    results = Rails.cache.fetch(
        username, expires_in: 2.hours
      ) do
      resp = self.search_twitter_api(
      'https://api.twitter.com/1.1/statuses/user_timeline.json',
      "?screen_name=#{username}&count=#{num_results}"
      )

      if resp&.try('errors').present? || resp&.try('error').present?
        return []
      end

      links = self.collect_links(resp)
      self.filter_sources(links)
    end
  end

  def self.collect_links(tweets)
    links = tweets.map do |tweet|
      tweet['entities']['urls'].map do |url_obj|
        url       = url_obj['expanded_url']
        shared_by = tweet['user']['screen_name']
        { url: url, shared_by: shared_by }
      end
    end

    links.flatten
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
