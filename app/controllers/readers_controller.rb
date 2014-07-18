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
    if passwordValidate(params[:reader][:password]) && emailValidate(params[:reader][:email]) && @reader.save
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
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      config.access_token        = current_reader.twitter_token
      config.access_token_secret = current_reader.twitter_token_secret
    end

    begin
      tweets    = client.home_timeline(options={count: 10})
      links     = Reader.twitter_feed(tweets)
      @articles = Article.parse(links)
    rescue
      @articles = { msg: "No data" }
    end
    render :json => @articles.to_json
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

  def passwordValidate(password)
    if password.match(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/)
      return true
    else
      flash[:notice] = "Password must be between 6 to 20 characters, contain one capital letter, and one number."
      return false
    end
  end

  def emailValidate(email)
    if email.match(/^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/)
      return true
    else
     flash[:alert] = "Invalid email."
     return false
    end
  end

  private
  def reader_params
    params.require(:reader).permit(:email, :password, :name, :image)
  end

end
