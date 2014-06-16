class Article < ActiveRecord::Base
<<<<<<< HEAD

  def self.parse(links)
    articles = links.map do |link|
      apikey      = 
      "b5d30b2a5642232b36da96334f8861205af1f4a8"
      #ENV.fetch('ALCHEMY_KEY')
=======
  validates :url, uniqueness: true
  has_many :reader_article_joins
  has_many :readers, through: :reader_article_joins

  def self.parse(links)
    articles = links.map do |link|
      apikey      = ENV['ALCHEMY_KEY']
>>>>>>> 84aef86727a9f8443bd6ac6e992193f6ae8bc6d5
      url         = link[:url]
      query       = "?apikey=#{apikey}&url=#{url}&outputMode=json"
      get_title = "http://access.alchemyapi.com/calls/url/URLGetTitle"+query
      get_text = "http://access.alchemyapi.com/calls/url/URLGetText"+query
      title = HTTParty.get(get_title)
      text  = HTTParty.get(get_text)['text']
<<<<<<< HEAD
      text_end = text.index(/\n/).to_i
      if text_end <= 60
        text_end = text.index('.').to_i + 1
<<<<<<< HEAD
      end        
      { title:   title['title'], 
        url:     title['url'], 
        extract: text[0, text_end],
        sharer:  link[:sharer] }      
    end

    articles.delete_if { |article| 
      article[:url].empty? || article[:extract].empty? ||
      article[:title].empty? }
  end


=======
      end
=======
      if text.nil? == false
        text_end = text.index(/\n/).to_i
        if text_end <= 60
          text_end = text.index('.').to_i + 1
        end
      else
        text_end = 0          
      end  

>>>>>>> e367bc11acbc39a7bd7d8f4c99ac1b959de8c127
      { title:     title['title'], 
        url:       title['url'], 
        extract:   text[0, text_end],
        shared_by: link[:shared_by] }      
    end

    articles.delete_if { |article| 
      article[:url].empty? || article[:extract].length <= 80 || 
      article[:title].empty? }
  end

>>>>>>> 84aef86727a9f8443bd6ac6e992193f6ae8bc6d5
end
