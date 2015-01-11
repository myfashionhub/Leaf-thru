module PocketApi
  attr_accessor :callback_url, :code,
                :access_token, :username

  def initialize
    Pocket.configure do |config|
      config.consumer_key = ENV['LT_POCKET_KEY']
    end

    @callback_url = '/auth/pocket/callback'
    @code
    @access_token
    @username
  end

  def self.connect
    @code = Pocket.get_code(redirect_uri: @callback_url)
    new_url = Pocket.authorize_url(code: @code, redirect_uri: @callback_url)
    puts "new_url: #{new_url}"
    new_url
  end

  def self.log
    puts "request.url: #{request.url}"
    puts "request.body: #{request.body.read}"
    result = Pocket.get_result(@code, redirect_uri: @callback_url)
    @access_token = result['access_token']
    @username = result['username']
    #session[:access_token] = Pocket.get_access_token(session[:code])
    puts @access_token
    puts @username
    { access_token: access_token, username: username }
  end

  def self.add
    client = Pocket.client(:access_token => session[:access_token])
    info = client.add :url => 'http://getpocket.com'
  end
end
