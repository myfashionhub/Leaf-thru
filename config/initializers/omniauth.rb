Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['LT_TWITTER_KEY'], ENV['LT_TWITTER_SECRET']
  provider :facebook, ENV['LT_FACEBOOK_ID'], ENV['LT_FACEBOOK_SECRET']
end
