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

=begin
blacklist: youtu.be, youtube.com, pin.it, pinterest.com, ow.ly,
=end

=begin
whitelist: slate.com, slate.me, wsj.com, bit.ly, vogue.cm, esqm.ag, esquire.com, vogue.com, on.mash, nytimes.com, nyti.ms, read.bi

=end

#  if article_url.include? 'on.mash'
#    title = doc.css("h1 [class='title']").children.text
#  elsif article_url.include? 'nyti.ms'
#    title = doc.css("h2 [class='story-heading']").children[0].text
#  elsif article_url.include? 'read.bi'
#    title = doc.css('h1').children[0].text
#  elsif article_url.include? 'slate'  
#    title = title = doc.css("h1 [class='hed']").children[0].text
#  else
#    title = article_url
#  end 
