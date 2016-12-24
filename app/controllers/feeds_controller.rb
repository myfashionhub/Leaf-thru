class FeedsController < ApplicationController
  before_action :require_login

  def index
    @reader = current_reader
  end

  def twitter
    articles = Rails.cache.fetch(
      "/#{current_reader.id}/twitter", expires_in: 2.hours
    ) do
      Feed.twitter(
        current_reader.twitter_token,
        current_reader.twitter_token_secret
      )
    end

    render json: articles.to_json
  end

  def rss
    articles = Rails.cache.fetch(
      "/#{current_reader.id}/rss", expires_in: 2.hours
    ) do
      Feed.rss(current_reader.subscriptions)
    end

    render json: articles.to_json
  end

end
