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

  def log_twitter
    data = request.env['omniauth.auth']
    current_reader.update({
      twitter_token: data.extra.access_token.params[:oauth_token],
      twitter_token_secret: data.extra.access_token.params[:oauth_token_secret],
      twitter_handle:data.info.nickname,
<<<<<<< HEAD
      #name:         data.info.name,
=======
      name:          data.info.name,
>>>>>>> 84aef86727a9f8443bd6ac6e992193f6ae8bc6d5
      image:         data.info.image,
      location:      data.info.location,
      tagline:       data.info.description })     
    redirect_to '/twitter'    
  end

  def log_facebook
    data = request.env['omniauth.auth']
    current_reader.update({
      facebook_token: data.credentials.token,
      facebook_uid:   data.uid,
<<<<<<< HEAD
      name:   data.info.name,
      #email: data.email,
      #image:  data.image 
      })
    render :json => data.to_json
=======
      name:           data.info.name
      email:          data.email,
      image:          data.image 
      })
    #render :json => data.to_json
    redirect_to '/facebook'
>>>>>>> 84aef86727a9f8443bd6ac6e992193f6ae8bc6d5
  end

end
