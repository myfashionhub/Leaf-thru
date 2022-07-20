class FeedsController < ApplicationController
  before_action :require_login

  def index
    @reader = current_reader
  end

  def twitter
    if current_reader.twitter_handle.nil?
      render json: []
      return
    end

    article_links = TwitterApi.get_timeline(current_reader.twitter_handle)

    message = "No article found for @#{current_reader.twitter_handle}."
    if article_links.size == 0
      render json: { message: message }
      return
    end

    articles = WatsonApi.get_articles(article_links)
    if articles.size == 0
      render json: { message: message }
    else
      render json: articles.to_json
    end
  end
end
