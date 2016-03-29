module Alchemy

  def self.get_articles(links)
    alchemy_url = "http://access.alchemyapi.com/calls/url"
    api_key     = ENV['LT_ALCHEMY_KEY']
    hydra = Typhoeus::Hydra.new

    requests = links.map do |link|
      query       = "?apikey=#{api_key}&url=#{link[:url]}&outputMode=json"
      title_query = alchemy_url + "/URLGetTitle" + query
      text_query  = alchemy_url + "/URLGetText" + query
      title_request = Typhoeus::Request.new(title_query, followlocation: true)
      text_request  = Typhoeus::Request.new(text_query, followlocation: true)

      # Queue up parse article requests
      hydra.queue(title_request)
      hydra.queue(text_request)

      {
        link: link,
        title_request: title_request,
        text_request: text_request
      }
    end
    hydra.run

    parse_responses(requests)
  end

  def self.parse_responses(requests)
    # Parse responses from hydra requests
    articles = requests.map do |res|
      link  = res[:link]
      title = JSON.parse(res[:title_request].response.response_body)
      text  = JSON.parse(res[:text_request].response.response_body)

      title     = title['title']
      url       = title['url'] || link[:url]
      extract   = get_extract(text['text'])

      if url.empty? || title.empty? || extract.length <= 30
        nil
      else
        {
          title: title,
          url: url,
          extract: extract,
          shared_by: link[:shared_by]
        }
      end
    end

    articles.compact
  end

  def self.get_extract(text)
    extract = ''
    if text.present?
      text_end = text.index(/\n/).to_i
      text_end = text.index('.').to_i + 1 if text_end <= 60
      extract  = text[0, text_end]
    end

    extract
  end
end
