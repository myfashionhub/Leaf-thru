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

  def authorize
    data = request.env['omniauth.auth']

    if params[:service] == 'twitter'
      Session.update_with_twitter(current_reader, data)
    elsif params[:service] == 'facebook'
      Session.update_with_facebook(current_reader, data)
    elsif params[:service] == 'pocket'
      # Step 4: receive callback
      data = pocket_api.authorize(current_reader.pocket_token)
      Session.update_with_pocket(current_reader, data)
    end

    flash[:notice] = "You have successfully connected your #{params[:service].capitalize} account."
    redirect_to '/profile'
  end

  def request_pocket
    # Step 2: request token from Pocket
    redirect_url = pocket_api.request_pocket(current_reader)

    if redirect_url.present?
      redirect_to redirect_url
    else
      render json: {msg: 'Error connecting with Pocket.'}
    end
  end

  def unauthorize
    if params[:service] == 'twitter'
      current_reader.update(
        twitter_token: nil,
        twitter_token_secret: nil
      )
    elsif params[:service] == 'facebook'
      current_reader.update(facebook_token: nil)
    elsif params[:service] == 'pocket'
      current_reader.update(pocket_token: nil)
    end

    render json: {
      msg: "You have successfully disconnected your #{params[:service].capitalize} account."
    }
  end

  private
  def pocket_api
    @pocket_api ||= PocketApi::Oauth.new(request.protocol + request.host_with_port)
  end
end
