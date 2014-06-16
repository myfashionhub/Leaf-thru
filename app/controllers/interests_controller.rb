class InterestsController < ApplicationController

  def index
    @interests = Interest.all
  end



end
