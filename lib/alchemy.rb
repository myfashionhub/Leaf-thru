module Alchemy

  def self.get_articles(links)
    alchemy_endpoint = "http://access.alchemyapi.com/calls/url"
    api_key          = ENV['LT_ALCHEMY_KEY']

    # Queue up parse article requests
    hydra = Typhoeus::Hydra.new

    requests = links.map do |link|
      query       = "?apikey=#{api_key}&url=#{link[:url]}&outputMode=json"
      title_query = alchemy_endpoint + "/URLGetTitle" + query
      text_query  = alchemy_endpoint + "/URLGetText" + query
      title_request = Typhoeus::Request.new(title_query, followlocation: true)
      text_request  = Typhoeus::Request.new(text_query, followlocation: true)
      hydra.queue(title_request)
      hydra.queue(text_request)

      {
        link: link,
        title_request: title_request,
        text_request: text_request
      }
    end
    hydra.run

    articles = self.parse_responses(requests)
    self.filter_articles(articles)
  end

  def self.parse_responses(requests)
    # Parse responses from hydra requests
    articles = requests.map do |response|
      link = response[:link]
      title_request = response[:title_request]
      text_request = response[:text_request]

      title = JSON.parse(title_request.response.response_body)
      text  = JSON.parse(text_request.response.response_body)['text']

      if !text.nil?
        text_end = text.index(/\n/).to_i
        text_end = text.index('.').to_i + 1 if text_end <= 60
        extract   = text[0, text_end]
      else
        extract = ''
      end

      title     = title['title'] || ''
      url       = title['url'] || link[:url]
      shared_by = link[:shared_by]

      {
        title: title,
        url: url,
        extract: extract,
        shared_by: shared_by
      }
    end
  end

  def self.filter_articles(articles)
    articles.delete_if do |article|
      article[:url].empty? || article[:title].empty? ||
      article[:extract].length <= 30
    end
  end

end
