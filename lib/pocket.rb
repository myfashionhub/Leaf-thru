module PocketApi
  attr_accessor :callback_url, :code,
                :access_token, :username

  def self.connect
    @callback_url = '/auth/pocket'
    url = 'https://getpocket.com/v3/oauth/request'
    body = {
      'consumer_key' => ENV['LT_POCKET_KEY'],
      'redirect_uri' => @callback_url
    }.to_json
    headers = {
      'Content-Type' => 'application/json; charset=UTF-8',
      'X-Accept' => 'application/json'
    }

    response = HTTParty.post(url, body: body, headers: headers)
    @code = response['code']
  end

  def self.log

    { access_token: access_token, username: username }
  end

  def self.add
    client = Pocket.client(:access_token => session[:access_token])
    info = client.add :url => 'http://getpocket.com'
  end
end
