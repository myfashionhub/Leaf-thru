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
    twitter_handle = reader_params[:twitter_handle]
    resp = TwitterApi.get_profile(twitter_handle)

    if resp&.try('errors').present?
      flash[:notice] = resp['errors'][0]['message']
    else
      current_user.update({
        twitter_handle: twitter_handle,
        image: resp['profile_image_url'],
        location: resp['location'],
        tagline: resp['description'],
      })
    end

    redirect_to '/feed'
  end

  def remove
    if params[:twitter_handle]
      current_user.update(twitter_handle: nil)
    end

    redirect_to '/feed'
  end

  private
  def reader_params
    params.require(:reader).permit(
      :email, :password, :name, :image, :update_location, :twitter_handle
    )
  end

end
