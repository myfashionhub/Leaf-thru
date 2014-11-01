require 'json'
require "#{Rails.root}/lib/alchemy"

class Article < ActiveRecord::Base
  has_many :bookmarks
  has_many :readers, through: :bookmarks
  validates :url, uniqueness: true

  def self.parse(links)
    requests = Alchemy.get_articles(links)
    articles = Alchemy.parse_responses(requests)
    Alchemy.filter_articles(articles)
  end

end
