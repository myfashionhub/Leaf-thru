class FeedsController < ApplicationController
  before_action :require_login

  def index
    @reader = current_reader
  end

  def twitter
    articles = Feed.twitter(current_reader.id, current_reader.twitter_handle)

    render json: articles.to_json
  end
end
