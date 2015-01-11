module Pocket
  def initialize
    Pocket::Client.new
    Pocket.configure do |config|
      config.consumer_key = ENV['LT_POCKET_KEY']
    end
  end
end
