class WelcomeController < ApplicationController
  def index
    if current_reader
      if current_reader.name
        @greeting = current_reader.name
      else
        @greeting = current_reader.email
      end  
    else  
      @greeting = 'Reader'
    end

    @reader = Reader.new  
  end

  def about

  end

end
