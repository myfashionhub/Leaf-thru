class ReadersController < ApplicationController
  before_action :require_login, on: :profile

  def new
    @reader = Reader.new
  end

  def create
    @reader = Reader.create(params_reader)
    if @reader.save
      redirect_to login_path
    else
      render :new
    end
  end

  def destroy
    @reader = Reader.find(current_reader.id)
  end

  def profile
    @reader = current_reader
    @publications = Publication.all
    @subscription = Subscription.new
  end

  def edit
    @reader = current_reader
    @publications = Publication.all
  end

  def update

    binding.pry
    #where publication id = true
    #update reader_publication w. reader[id]_publication[id]
  end

  def twitter
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = current_reader.twitter_token
      config.access_token_secret = current_reader.twitter_token_secret
    end

    tweets    = client.home_timeline(options={count: 10})
    links     = Reader.twitter_feed(tweets)
    @articles = Article.parse(links)

    respond_to do |format|
      format.html
      format.json { render :json => @articles.to_json }
    end
  end

  def facebook
    @reader = current_reader
    #render :json => data.to_json
  end

  def feed
    #@feeds = current_reader.interests.all
  end

  private
  def reader_params
    params.require(:reader).permit(:email, :password, :preferences)
  end

end
