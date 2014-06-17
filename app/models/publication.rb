class Publication < ActiveRecord::Base
  has_many  :readers
end
