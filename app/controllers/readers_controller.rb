class ReadersController < ApplicationController
  before_action :require_login, only: :profile

  def index
  end

  def create
    result = Reader.create_with_params(reader_params)

    if result[:status] == 'success'
      current_reader = login(reader_params[:email], reader_params[:password])
    end
    render json: result
  end

  def customize
    # Render template
  end

  def profile
    # Render template
  end

  def update
    reader = current_reader

    if reader_params[:update_location] == 'true'
      location = reader.update_location(remote_ip)
      render json: { location: location }
    else
      reader.update(reader_params)
      render json: { msg: "You have successfully updated your profile." }.to_json
    end
  end


  private
  def reader_params
    params.require(:reader).permit(
      :email, :password, :name, :image, :update_location
    )
  end

end
