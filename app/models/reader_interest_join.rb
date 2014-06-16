class ReaderInterestJoin < ActiveRecord::Base
  belongs_to :reader
  belongs_to :interest
end
