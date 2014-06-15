class Article < ActiveRecord::Base

  def self.parse(links)
    articles = links.map do |link|
      apikey      = ENV['ALCHEMY_KEY']

      url         = link[:url]
      query       = "?apikey=#{apikey}&url=#{url}&outputMode=json"
      get_title = "http://access.alchemyapi.com/calls/url/URLGetTitle"+query
      get_text = "http://access.alchemyapi.com/calls/url/URLGetText"+query
      title = HTTParty.get(get_title)
      text  = HTTParty.get(get_text)['text']
      text_end = text.index(/\n/).to_i
      if text_end <= 60
        text_end = text.index('.').to_i + 1
      end
      { title:   title['title'], 
        url:     title['url'], 
        extract: text[0, text_end],
        sharer:  link[:sharer] }      
    end

    articles.delete_if { |article| 
      article[:url].empty? || article[:extract].length <= 60 || 
      article[:title].empty? }
  end

end
