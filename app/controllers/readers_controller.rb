class ReadersController < ApplicationController
  before_action :require_login, only: :profile

  def index
  end

  def create
    info = Reader.create_reader(reader_params)
    if (info[:status] === 'success')
      current_reader = login(reader_params['email'], reader_params['password'])
    end
    render json: { msg: info[:msg], status: info[:status] }
  end

  def destroy
    @reader = Reader.find(current_reader.id)
  end

  def profile
    @reader = current_reader
    @publications = Publication.all
    @subscription = Subscription.new
  end

  def update
    reader = current_reader

    if reader_params[:update_location] == 'true'
      location = reader.update_location(remote_ip)
      render json: { location: location }
    else
      reader.update(reader_params)
      render json: { msg: "You have successfully updated your profile." }.to_json
    end
  end


  def twitter_feed
    articles = Reader.twitter_feed(
                  current_reader.twitter_token,
                  current_reader.twitter_token_secret
                )
    render json: articles.to_json
  end

  def rss_feed
    subscriptions = current_reader.subscriptions
    articles = Reader.rss_feed(subscriptions)
    render json: articles.to_json
  end

  def feed
    @reader = current_reader
  end

  private
  def reader_params
    params.require(:reader).permit(
      :email, :password, :name, :image, :update_location
    )
  end

end
