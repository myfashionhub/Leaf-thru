require 'net/http'

module Pocket

  class Api
    attr_reader :consumer_key,
                :callback_url, :request_token,
                :access_token, :username

    def initialize(host_url)
      @callback_url = host_url + '/auth/pocket/callback'
      @consumer_key = ENV['LT_POCKET_KEY']
    end

    def request_token
      url  = 'https://getpocket.com/v3/oauth/request'
      body = {
        'consumer_key' => consumer_key,
        'redirect_uri' => callback_url
      }.to_json

      redirect_url = ''
      begin
        response = post_request(url, body)

        request_token = JSON.parse(response.body)['code']
        redirect_url = 'https://getpocket.com/auth/authorize?'
                       'request_token='+ request_token +
                       '&redirect_uri='+ callback_url
      rescue => error
        Rails.logger.error(error)
      end

      redirect_url
    end


    def authorize
      url = 'https://getpocket.com/auth/authorize'
      body = {
        'consumer_key' => consumer_key,
        'code' => request_token
      }
      response = post_request(url, body)
    end

    def add
      client = Pocket.client(:access_token => session[:access_token])
      info = client.add :url => 'http://getpocket.com'
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
      req.body = body

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.request(req)
    end
  end

end
