
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_reader, :format_date, :remote_ip

  def current_reader
    current_user
  end

  def not_authenticated
    redirect_to root_path
  end

  def format_date(object)
    object.strftime("%B %-d, %Y")
  end

  def remote_ip
    if request.remote_ip == '127.0.0.1'
      '74.66.83.223'
    else
      request.remote_ip
    end
  end

  def hostname
    request.host_with_port
  end
end
