class WelcomeController < ApplicationController
  def index
    if current_user 
      redirect_to '/feed'
    else   
      @reader = Reader.new
    end  
  end

  def about
  end

end
