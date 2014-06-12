class ReadersController < ApplicationController
  before_action :require_login, only: [:profile]

  def new
    @reader = Reader.new
  end

  def create
    @reader = Reader.create(params_reader)
    if @reader.save
      redirect_to login_path
    else
      render :new
    end    
  end

  def edit
    # profile route
    @reader = Reader.find(current_reader.id)
  end

  def destroy
  end

  private
  def params_reader
    params.require(:reader).permit(:email, :password)
  end

end  
