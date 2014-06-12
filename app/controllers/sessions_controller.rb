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

  # Track OAuth
  def log
    data = request.env['omniauth.auth']
    render :json => data.to_json
  end      
end  
