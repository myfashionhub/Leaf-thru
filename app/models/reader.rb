class Reader < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_presence_of :password, on: :create
  validates_presence_of :email, on: :create  
  validates_uniqueness_of :email

  #validates :email, email: true
  validates :password, length: {within: 6..16, wrong_length: "Password length does not match requirement"}, :on => :create

  before_save :downcase_email


  def downcase_email
    self.email.downcase!
  end 

  def self.twitter_feed(tweets) 
    links = tweets.map do |tweet|
      url    = tweet.urls[0]
      if url.nil? == false
        url.attrs[:expanded_url] 
        sharer = tweet.user.screen_name
        { url: url.attrs[:expanded_url], sharer: sharer }
      end  
    end
    return links.compact
  end

end
