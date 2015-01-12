
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_reader, :formatted_date_time,
                :remote_ip

  def current_reader
    current_user
  end

  def not_authenticated
    redirect_to root_path
  end

  def formatted_date_time(object)
    object.strftime("%B %d, %Y")
  end

  def remote_ip
    if request.remote_ip == '127.0.0.1'
      '184.153.102.108'
    else
      request.remote_ip
    end
  end

  def hostname
    request.host_with_port
  end
end
