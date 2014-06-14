class Article < ActiveRecord::Base

  def self.parse(links)
    links.map do |link|
      apikey      = 
      "b5d30b2a5642232b36da96334f8861205af1f4a8"
      #ENV.fetch('ALCHEMY_KEY')
      url         = link[:url]
      query       = "?apikey=#{apikey}&url=#{url}&outputMode=json"
      get_title = "http://access.alchemyapi.com/calls/url/URLGetTitle"+query
      get_text = "http://access.alchemyapi.com/calls/url/URLGetText"+query
      title = HTTParty.get(get_title)
      text  = HTTParty.get(get_text)

      text_end = text['text'].index(/\n/).to_i
      { title:   title['title'], 
        url:     title['url'], 
        extract: text['text'][0, text_end],
        sharer:  link[:sharer] }      
    end
  end



end
