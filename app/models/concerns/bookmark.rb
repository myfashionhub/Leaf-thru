class Bookmark < ActiveRecord::Base
  belongs_to :readers
  belongs_to :articles
end
