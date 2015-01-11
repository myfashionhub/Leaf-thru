class ReadersController < ApplicationController
  before_action :require_login, only: :profile

  def index
  end

  def create
    info = Reader.create_reader(reader_params)
    if (info[:status] === 'success')
      current_reader = login(email, password)
    end
    render json: {msg: info[:msg], status: info[:status]}
  end

  def destroy
    @reader = Reader.find(current_reader.id)
  end

  def profile
    @reader = current_reader
  end

  def subscription
    @publications = Publication.all
    @subscription = Subscription.new
  end

  def update
    @reader = current_reader
    # if passwordValidate(params[:reader][:password]) && emailValidate(params[:reader][:email])
      @reader.update(reader_params)
      render json: { msg: "You have successfully updated your profile." }.to_json
    # end
  end

  def update_location
    Reader.update_location(params)
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
  end

  private
  def reader_params
    params.require(:reader).permit(:email, :password, :name, :image)
  end

end
