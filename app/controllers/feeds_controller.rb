class FeedsController < ApplicationController
  before_action :require_login

  def index
    @reader = current_reader
  end

  def twitter
    articles = Feed.twitter(
                 current_reader.twitter_token,
                 current_reader.twitter_token_secret
               )
    render json: articles.to_json
  end

  def rss
    articles = Feed.rss(current_reader.subscriptions)
    render json: articles.to_json
  end

end
