class ReadersController < ApplicationController
  before_action :require_login, on: :profile

#  def new
#    @reader = Reader.new  #in welcome index
#  end

  def create
    if current_reader
      flash[:notice] = 'You must log out to create a new account'
    end

    @reader = Reader.create(reader_params)
    if @reader.save
      current_reader = login(params[:reader][:email], params[:reader][:password])  
      redirect_to '/profiles', notice: 'Successfully signed up.'
    else
      redirect_to root_path, alert: 'Sign up failed. Try again.'
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
    subscriptions = current_reader.subscriptions
    feeds = []
    subscriptions.each do |subscription|
      id = subscription.publication_id
      if id != nil
        publication = Publication.find(id)
        feeds << publication.url
      end
    end
    return feeds.uniq
  end

  private
  def reader_params
    params.require(:reader).permit(:email, :password, :preferences)
  end

end
