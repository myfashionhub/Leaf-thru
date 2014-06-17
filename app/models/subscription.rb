class Subscription < ActiveRecord::Base
 belongs_to :reader
 belongs_to :publication
end
