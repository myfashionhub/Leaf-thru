class ReadersController < ApplicationController
  before_action :require_login, only: :profile

  def index
  end

  def create
    @reader = Reader.new(reader_params)
    if Reader.find_by(email: params[:reader][:email])
      redirect_to root_path
      flash[:alert] = "Email already taken."
    end

    if Reader.validate_password(params[:reader][:password]) &&
      Reader.validate_email(params[:reader][:email]) && @reader.save
        current_reader = login(params[:reader][:email], params[:reader][:password])
      redirect_to '/profile'
      flash[:notice] = 'Successfully signed up.'
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
    # if passwordValidate(params[:reader][:password]) && emailValidate(params[:reader][:email])
      @reader.update(reader_params)
      render json: { msg: "You have successfully updated your profile." }.to_json
    # end
  end

  def twitter
    # client = Twitter::REST::Client.new do |config|
    #   config.consumer_key        = ENV['TWITTER_KEY']
    #   config.consumer_secret     = ENV['TWITTER_SECRET']
    #   config.access_token        = current_reader.twitter_token
    #   config.access_token_secret = current_reader.twitter_token_secret
    # end
    # tweets    = client.home_timeline(options={count: 15})
    tweets    = Twitter.get_feed(current_reader.twitter_token,
                current_reader.twitter_token_secret)
    links     = Reader.get_links(tweets)

    @articles = Article.parse(links)
    render :json => @articles.to_json
  end

  def feed
    # Rss feeds
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
    params.require(:reader).permit(:email, :password, :name, :image)
  end

end
