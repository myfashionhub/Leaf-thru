class ReaderInterestJoinsController < ApplicationController

  def index
    @reader_interest_joins = ReaderInterestJoin.all
  end

  def new
    @reader_interest_join = ReaderInterestJoin.new
  end

  def create
    @reader_interest_join = ReaderInterestJoin.create(reader_interest_join_params)
    #redirect_to reader_interest_join_path(reader_interest_join)
  end




private

  def reader_interest_join_params
    params.require(:reader_interest_join).permit(:reader_id, :interest_id)
  end


end
