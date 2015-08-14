require "#{Rails.root}/lib/pocket"

class SessionsController < ApplicationController
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
    flash[:notice] = "You have successfully logged out."
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
    flash[:notice] = "You have successfully connected your Twitter account."
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
    redirect_to '/profile#social'
    flash[:notice] = "You have successfully connected your Facebook account."
  end

  def request_pocket
    PocketApi.request
    @pocket_url = PocketApi.redirect
    redirect_to @pocket_url
  end

  def authorize_pocket
    response = PocketApi.authorize
    puts response
    # current_reader.update(
    #   pocket_token: data[:access_token],
    #   pocket_username: data[:username]
    # )
    redirect_to '/profile'
  end

  def logout_fb
    current_reader.update(facebook_token: nil, facebook_uid: nil)
    redirect_to '/profile#social'
    flash[:notice] = "You have disconnected your Facebook account."
  end

  def logout_tw
    current_reader.update(twitter_token: nil, twitter_token_secret: nil, twitter_handle: nil)
    redirect_to '/profile#social'
    flash[:notice] = "You have disconnected your Twitter account."
  end

end
