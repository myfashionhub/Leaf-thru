class FeedsController < ApplicationController
  before_action :require_login

  def index
    @reader = current_reader
  end

  def twitter
    articles = Rails.cache.fetch(
      "/#{current_reader.id}/twitter/articles", expires_in: 2.hours
    ) do
      articles = Feed.twitter(
        current_reader.id,
        current_reader.twitter_token,
        current_reader.twitter_token_secret
      )
    end

    render json: articles.to_json
  end
end
