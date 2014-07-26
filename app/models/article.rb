require 'json'

class Article < ActiveRecord::Base
  has_many :bookmarks
  has_many :readers, through: :bookmarks
  validates :url, uniqueness: true

  def self.parse(links)
    hydra = Typhoeus::Hydra.new
    requests = links.map do |link|
      apikey      = ENV['ALCHEMY_KEY']
      url         = link[:url]
      query       = "?apikey=#{apikey}&url=#{url}&outputMode=json"
      title_query = "http://access.alchemyapi.com/calls/url/URLGetTitle"+query
      text_query  = "http://access.alchemyapi.com/calls/url/URLGetText"+query
      title_request = Typhoeus::Request.new(title_query, followlocation: true)
      text_request  = Typhoeus::Request.new(text_query, followlocation: true)
      hydra.queue(title_request)
      hydra.queue(text_request)

      { link: link, title_request: title_request, text_request: text_request }
    end
    hydra.run

    articles = requests.map do |response|
      link = response[:link]
      title_request = response[:title_request]
      text_request = response[:text_request]

      title = JSON.parse(title_request.response.response_body)
      text  = JSON.parse(text_request.response.response_body)['text']

      if text.nil? == false
        text_end = text.index(/\n/).to_i
        text_end = text.index('.').to_i + 1 if text_end <= 60
      else
        text_end = 0
      end
      { title:     title['title'],
        url:       title['url'],
        extract:   text[0, text_end],
        shared_by: link[:shared_by] }
    end

    articles.delete_if { |article|
      article[:url].empty? || article[:extract].length <= 80 ||
      article[:title].empty?
    }
      # title = HTTParty.get(get_title)
      # text  = HTTParty.get(get_text)['text']
  end


end
