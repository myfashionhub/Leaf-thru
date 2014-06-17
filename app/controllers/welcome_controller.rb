class WelcomeController < ApplicationController
  def index
    if current_reader
      @reader  = current_reader
    else  
      @reader = 'Reader'
    end  
  end

  def about

  end

end
