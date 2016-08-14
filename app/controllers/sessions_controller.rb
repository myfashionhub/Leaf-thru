class SessionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def new
  end

  def create
    reader = login(params[:email].downcase, params[:password])
    info = Session.create_new(reader, params)
    render json: {msg: info[:msg], status: info[:status]}
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def log_twitter
    data = request.env['omniauth.auth']
    current_reader.update({
      twitter_token: data.extra.access_token.params[:oauth_token],
      twitter_token_secret: data.extra.access_token.params[:oauth_token_secret],
      twitter_handle:data.info.nickname,
      name:          data.info.name,
      image:         data.info.image,
      location:      data.info.location,
      tagline:       data.info.description
    })
    redirect_to '/feed'
  end

  def log_facebook
    data = request.env['omniauth.auth']
    current_reader.update({
      facebook_token: data.credentials.token,
      facebook_uid:   data.uid,
      name:   data.info.name,
      #email: data.info.email,
      image:  data.info.image
    })
    redirect_to '/feed'
  end

  def request_pocket
    redirect_url = pocket_api.request_token
    redirect_to redirect_url
  end

  def authorize_pocket
    response = pocket_api.authorize
    # current_reader.update(
    #   pocket_token: data[:access_token],
    #   pocket_username: data[:username]
    # )
    redirect_to '/feed'
  end

  def logout_fb
    current_reader.update(facebook_token: nil, facebook_uid: nil)
    redirect_to '/feed'
  end

  def logout_tw
    current_reader.update(
      twitter_token: nil, 
      twitter_token_secret: nil, 
      twitter_handle: nil
    )
    redirect_to '/feed'
  end

  private
  def pocket_api
    @pocket_api ||= Pocket::Api.new(request.protocol+request.host_with_port)
  end

end
