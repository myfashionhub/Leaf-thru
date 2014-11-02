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

  def twitter_feed
    articles = Reader.twitter_feed(
                  current_reader.twitter_token,
                  current_reader.twitter_token_secret
                )
    puts articles
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
