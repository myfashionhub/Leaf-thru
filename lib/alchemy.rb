require 'net/http'
require 'uri'

module Alchemy
  def self.get_articles(links)
    alchemy_url = "https://apikey:#{ENV['LT_WATSON_API_KEY']}@gateway-wdc.watsonplatform.net/" +
      "natural-language-understanding/api/v1/analyze?"
    hydra = Typhoeus::Hydra.new

    # links: {url: url, shared_by: shared_by}
    requests = links.map do |link|
      request = build_request(link[:url], alchemy_url)

      if request.present?
        hydra.queue(request)
        {
          shared_by: link[:shared_by],
          request: request,
        }
      else
        nil
      end
    end

    hydra.run # Execute all queued requests
    parse_responses(requests.compact)
  end

  def self.build_request(article_url, alchemy_url)
    # Attemp to get redirect URL of short links
    # If article_url isn't a short link, it's likely to be
    # a Twitter status URL. Skip it if this is the case.
    url = Net::HTTP.get_response(URI(article_url))['location']
    return nil if url.nil?

    params = {
      'url' => url,
      'language' => 'en',
      'features' => 'metadata',
      'clean' => true,
      'return_analyzed_text' => true,
      'limit_text_characters' => 300,
      'version' => '2018-03-16'
    }
    query_url = alchemy_url
    params.each do |key, value|
      query_url += "#{key}=#{value}&"
    end

    Typhoeus::Request.new(query_url, followlocation: true)
  end

  def self.parse_responses(requests)
    articles = requests.map do |resp|
      status = resp[:request].response.options[:response_code]
      return nil if status != 200

      begin
        body = JSON.parse(resp[:request].response.response_body)
      rescue
        return nil
      end

      metadata = body['metadata']
      extract = sanitize_extract(body['analyzed_text'])
      if !metadata['title'].present? || extract.length <= 30
        nil
      else
        {
          title: metadata['title'],
          url: body['retrieved_url'],
          extract: extract,
          shared_by: resp[:shared_by]
        }
      end
    end

    articles.compact
  end

  def self.sanitize_extract(text)
    return '' if !text.present?

    text = text.gsub(/(\\n|\\t|\\r)/, '').strip

    last_char = text[text.size - 1]
    if last_char != '.'
      # Replace the last word (in case it is cut off or punctuation with ellipses
      index = text.size - 50
      text_end = text[index, text.size - 1]
      text_end = text_end.gsub(/((\s|\W)\w+|\W|\s)$/, '...')
      text = text[0, index] + text_end
    end

    text
  end
end
