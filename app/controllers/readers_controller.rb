class ReadersController < ApplicationController
  before_action :require_login, only: :profile

  def index
    readers = Reader.all
    @supscriptions = readers.map do |reader| 
      
    end
  end

  def create
    @reader = Reader.create(reader_params)
    if current_reader
      redirect_to root_path
      flash[:alert] = 'You must log out to create a new account'
    end    
    if @reader.save
      current_reader = login(params[:reader][:email], params[:reader][:password])
      redirect_to '/profile'
      flash[:notice] = 'Successfully signed up.'
    else
      redirect_to root_path
      flash[:alert] = 'Sign up failed. Try again.'
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
    @reader = current_reader
    @reader.update(reader_params)
    redirect_to profile_path
    flash[:notice] = "You have successfully updated your profile."
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
  end

  def feed
    subscriptions = current_reader.subscriptions
    @feeds = []
    subscriptions.each do |subscription|
      id = subscription.publication_id
      publication = Publication.find(id)
      @feeds << publication.url
    end
  end

  private
  def reader_params
    params.require(:reader).permit(:email, :password, :preferences, :name, :image)
  end

end
