require 'net/http'
require 'uri'

module Alchemy
  def self.get_articles(links)
    alchemy_url = "https://api.us-east.natural-language-understanding.watson.cloud.ibm.com/" +
      "instances/#{ENV['LT_WATSON_API_INSTANCE']}/v1/analyze"

    # links: {url: url, shared_by: shared_by}
    articles = links.map do |link|
      Rails.cache.fetch(
        link, expires_in: 2.hours
      ) do
        resp = self.make_request(link[:url], alchemy_url)
        self.parse_response(resp)
      end
    end

    articles.compact
  end

  def self.make_request(article_url, alchemy_url)
    params = {
      'url' => article_url,
      'language' => 'en',
      'features' => 'metadata',
      'clean' => true,
      'return_analyzed_text' => true,
      'limit_text_characters' => 300,
      'version' => '2022-04-07'
    }
    query_string = '?'
    params.each do |key, value|
      query_string += "#{key}=#{value}&"
    end

    uri = URI(alchemy_url)
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(uri.path.concat(query_string))
    request.basic_auth("apikey", ENV['LT_WATSON_API_KEY'])

    resp = https.request(request)
    JSON.parse(resp.body)
  end

  def self.parse_response(body)
    return nil if body['error']

    metadata = body['metadata']
    extract = sanitize_extract(body['analyzed_text'])

    if metadata['title'].empty? || extract.length <= 30
      nil
    else
      {
        title: metadata['title'],
        url: body['retrieved_url'],
        extract: extract,
        author: metadata['authors'].map { |a| a['name'] }.join(', ')
      }
    end
  end

  def self.sanitize_extract(text)
    return '' if !text.present?

    text = text.gsub(/(\\n|\\t|\\r)/, '').strip

    last_char = text[text.size - 1]
    if last_char != '.'
      # Replace the last word (in case it is cut off or punctuation with ellipses
      index = text.size - 50
      text_end = text[index, text.size - 1]

      return text if !text_end.present?

      text_end = text_end.gsub(/((\s|\W)\w+|\W|\s)$/, '...')
      text = text[0, index] + text_end
    end

    text
  end
end
