class Article < ActiveRecord::Base
  has_many :bookmarks
  has_many :readers, through: :bookmarks

  validates :url, uniqueness: true
end
