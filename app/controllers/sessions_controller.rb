class SessionsController < ApplicationController
  def new
  end

  def create
    @reader = login(params[:email].downcase, params[:password])
    if @reader
      redirect_to '/profile'
      flash[:notice] = "Logged in as #{@reader.email}" 
    else
      flash[:alert] = 'Log in failed. Try again'
      redirect_to root_path
    end
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
      tagline:       data.info.description })
    redirect_to '/profile'
  end

  def log_facebook
    data = request.env['omniauth.auth']
    current_reader.update({
      facebook_token: data.credentials.token,
      facebook_uid:   data.uid,
      name:   data.info.name,
      #email: data.info.email,
      image:  data.info.image })
    redirect_to '/profile'
  end

  def logout_fb
    current_reader.update(facebook_token: nil, facebook_uid: nil)
    redirect_to '/profile'
    #flash notice
  end
    
  def logout_tw
    current_reader.update(twitter_token: nil, twitter_token_secret: nil)
    redirect_to '/profile'
  end

end
