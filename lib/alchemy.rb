require 'net/http'
require 'uri'

module Alchemy

  def self.get_articles(links)
    alchemy_url = "https://gateway-a.watsonplatform.net/calls/url/URLGetCombinedData"
    api_key     = ENV['LT_ALCHEMY_KEY']
    hydra = Typhoeus::Hydra.new

    requests = links.map do |link|
      # Attempt to get redirect URL of short links
      url = Net::HTTP.get_response( URI(link[:url]) )['location']

      query = "#{alchemy_url}?apikey=#{api_key}&url=#{url}" +
        "&outputMode=json&extract=title&showSourceText=1&sourceText=cleaned"
      request = Typhoeus::Request.new(query, followlocation: true)
      hydra.queue(request)

      {
        link: link,
        request: request
      }
    end

    hydra.run # Execute all queued requests
    parse_responses(requests)
  end

  def self.parse_responses(requests)
    articles = requests.map do |res|
      status = res[:request].response.options[:response_code]
      return nil if status != 200

      begin
        response = JSON.parse(res[:request].response.response_body)
      rescue # In case response body isn't JSON
        return nil
      end

      title   = response['title']
      extract = get_extract(response['text'])

      if !title.present? || extract.length <= 30
        nil
      else
        {
          title: title,
          url: res[:link][:url],
          extract: extract,
          shared_by: res[:link][:shared_by]
        }
      end
    end

    articles.compact
  end

  def self.get_extract(text)
    extract = ''
    return extract if !text.present?

    # Get first paragraph or some sentences, limit 250 characters
    text.strip!
    text_end = text.index(/\n/).to_i
    if text_end <= 250
      extract = text[0, text_end]
    else
      text.gsub('\n', ' ').split('. ').each do |sentence|
        sentence = sentence + '. '
        extract += sentence if (extract + sentence).length <= 250
      end
    end

    extract
  end
end
