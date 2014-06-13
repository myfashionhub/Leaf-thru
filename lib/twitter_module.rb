module Twitter
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV["TWITTER_KEY"]
    config.consumer_secret     = ENV["TWITTER_SECRET"]
    config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
  end

  def get_links(handle)
    # lack permission to get all friends??
    # friends = client.friends(handle).to_a 
    friends = client.friends(handle).attrs[:users]
    timelines = friends.map do |friend| 
       client.user_timeline(friend.screen_name)
    end    
    
    tweets = timelines.map do |tweet|
      client.status(tweet.id)
      #fetch tweet by ID      
    end

    links = tweets.map do |tweet|
      tweet.urls[0].expanded_url.to_s #may be empty
    end  

  end  

  def get_followers(handle) 
    followers = client.followers("myfashionhub").attrs[:users]
  end

end


#  tweet_array = client.user_timeline(username)
#  results = tweet_array.map do |tweet|
#    if tweet.urls[0] != nil
#      {handle: username,
#       content: tweet.text, 
#       url: tweet.urls[0].expanded_url.to_s}
#    else 
#      {handle: username,
#       content: tweet.text}
#    end
