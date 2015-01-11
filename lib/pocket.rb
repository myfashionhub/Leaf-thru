module PocketApi
  attr_accessor :consumer_key, :headers,
                :callback_url, :request_token,
                :access_token, :username

  def self.request
    # 'http://leafthru.nessanguyen.com/auth/pocket/callback'
    @callback_url = 'http://127.0.0.1:3000/auth/pocket/callback'
    @consumer_key = ENV['LT_POCKET_KEY']
    url = 'https://getpocket.com/v3/oauth/request'

    body = {
      'consumer_key' => @consumer_key,
      'redirect_uri' => @callback_url
    }.to_json

    @headers = {
      'Content-Type' => 'application/json; charset=UTF-8',
      'X-Accept' => 'application/json'
    }

    response = HTTParty.post(url, body: body, headers: @headers)
    @request_token = response['code']
  end

  def self.redirect
    url = 'https://getpocket.com/auth/authorize?'
    query = 'request_token='+@request_token+'&redirect_uri='+@callback_url
    return url+query
  end

  def self.authorize
    url = 'https://getpocket.com/auth/authorize?'
    body = {
      'consumer_key' => @consumer_key,
      'code' => @request_token
    }
    response = HTTParty.post(url, body:body, headers:@headers)
  end

  def self.add
    client = Pocket.client(:access_token => session[:access_token])
    info = client.add :url => 'http://getpocket.com'
  end
end
