class SessionsController < ApplicationController

  def new
    #login form
  end

  def create
    @reader = login(params[:email].downcase, params[:password])
    if @reader
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  def log
    data = request.env['omniauth.auth']
    current_reader.update({
      twitter_token: data.extra.access_token.params[:oauth_token],
      twitter_token_secret: data.extra.access_token.params[:oauth_token_secret], 
      twitter_handle: data.info.nickname,
      name:           data.info.name,
      location:       data.info.location,
      profile_pic:    data.info.image,
      tagline:        data.info.description})  
    twitter_id      = data.extra.access_token.params[:user_id]
    redirect_to 'twitter'    
  end
end
