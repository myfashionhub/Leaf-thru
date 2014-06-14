class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_reader

  def current_reader
    current_user
  end

  def not_authenticated
    redirect_to login_path
  end  
end
