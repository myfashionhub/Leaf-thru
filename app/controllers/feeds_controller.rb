class FeedsController < ApplicationController
  before_action :require_login

  def index
    @reader = current_reader
  end

  def twitter
    article_links = TwitterApi.get_timeline(current_reader.twitter_handle)
    articles = WatsonApi.get_articles(article_links)

    render json: articles.to_json
  end
end
