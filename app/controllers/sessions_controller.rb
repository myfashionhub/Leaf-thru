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
    #binding.pry
    #render :json => data.to_json
    current_reader.update({
      twitter_token: data.extra.access_token.params[:oauth_token],
      twitter_token_secret: data.extra.access_token.params[:oauth_token_secret]})  
    twitter_id      = data.extra.access_token.params[:user_id]
    redirect_to 'twitter'
#    twitter_handle  = data.info.nickname
#    twitter_name    = data.info.name
#    twitter_location= data.info.location
#    twitter_avatar  = data.info.image
#    twitter_desc    = data.info.description 
  end
end
