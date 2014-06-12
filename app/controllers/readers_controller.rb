class ReadersController < ApplicationController
  validates :email
  validates :password, length: {within: 6..16, wrong_length: "Password length does not match requirement"}, :on => :create

  before_action :require_login, only: [:profile]
  before_save :downcase_email

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
    @reader = Reader.find(session[:reader_id])
  end

  def destroy
  end

  def downcase_email
    params.require(:reader).permit(:email).downcase!
  end 

  private
  def params_reader
    params.require(:reader).permit(:email, :password)
  end

end  
