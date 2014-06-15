class ReadersController < ApplicationController
  before_action :require_login, only: [:profile]

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
  end

  def edit
    @reader = current_reader
  end

  def update
    @reader = current_reader
    @reader.update(params_reader)
    redirect_to profile_path
  end

  def twitter
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = current_reader.twitter_token
      config.access_token_secret = current_reader.twitter_token_secret
    end

    tweets = client.home_timeline(options={count: 50})
    links  = Reader.twitter_feed(tweets)
    @data  = Article.parse(links)
    respond_to do |format| 
      format.html
      format.json { render :json => @data.to_json }
    end
    
  end

  def facebook
    graph = Koala::Facebook::API.new(current_reader.facebook_token, ENV['FACEBOOK_SECRET'])
    @reader = current_reader
    #render :json => feed.to_json
  end 

  def feed
    #@feeds = current_reader.interests.all
  end

  private
  def params_reader
    params.require(:reader).permit(:email, :password)
  end

end
