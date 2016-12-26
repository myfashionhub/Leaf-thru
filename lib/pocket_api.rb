require 'net/http'

module PocketApi

  class Oauth
    attr_reader :consumer_key,
                :callback_url, :request_token,
                :access_token, :username

    def initialize(host_url)
      @callback_url = host_url + '/auth/pocket/callback'
      @consumer_key = ENV['LT_POCKET_KEY']
    end

    def request_pocket(reader)
      # Step 2: get request_token from Pocket
      url  = 'https://getpocket.com/v3/oauth/request'
      body = {
        'consumer_key' => consumer_key,
        'redirect_uri' => callback_url
      }

      redirect_url = ''
      begin
        response = post_request(url, body)
        @request_token = JSON.parse(response.body)['code']

        # Save request_token on reader bc it can't be persisted through the steps
        reader.update(pocket_token: request_token)
        redirect_url = "https://getpocket.com/auth/authorize?" +
                       "request_token=#{request_token}" +
                       "&redirect_uri=#{callback_url}"
      rescue => error
        Rails.logger.error(error)
      end

      # Step 3: redirect back to Pocket
      redirect_url
    end


    def authorize(request_token)
      # Step 5: convert request token to access token
      url = 'https://getpocket.com/v3/oauth/authorize'
      body = {
        'consumer_key' => consumer_key,
        'code' => request_token
      }

      response = post_request(url, body)
      JSON.parse(response.body)
    end

    private
    def headers
      @headers ||= {
        'Content-Type' => 'application/json; charset=UTF-8',
        'X-Accept' => 'application/json'
      }
    end

    def post_request(url, body)
      uri  = URI.parse(url)
      req  = Net::HTTP::Post.new(uri.path, headers)
      req.body = body.to_json

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.request(req)
    end
  end

end
