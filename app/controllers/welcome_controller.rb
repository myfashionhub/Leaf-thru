class WelcomeController < ApplicationController
  def index
    @reader  = Reader.new
  end

  def about
  end

end
