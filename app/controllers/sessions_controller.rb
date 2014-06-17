class SessionsController < ApplicationController
  def new
    #login form
  end

  def create
    @reader = login(params[:email].downcase, params[:password])
    if @reader
      redirect_to '/feed'
    else
      redirect_to root_path, notice: 'Log in failed. Try again'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You have successfully logged out."
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
      tagline:       data.info.description })
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

end
