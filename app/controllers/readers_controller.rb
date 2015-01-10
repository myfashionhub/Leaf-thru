class ReadersController < ApplicationController
  before_action :require_login, only: :profile

  def index
  end

  def create
    puts params
    puts reader_params
    @reader = Reader.new(reader_params)
    if Reader.find_by(email: params[:reader][:email])
       msg = "Email already taken."
       status = 'error'
    elsif Reader.validate_password(params[:reader][:password]) &&
      Reader.validate_email(params[:reader][:email]) && @reader.save
        current_reader = login(params[:reader][:email], params[:reader][:password])
      msg = 'Successfully signed up.'
      status = 'success'
    end

    render json: { msg: msg, status: status }
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
