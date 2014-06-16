class Reader < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_presence_of :password, on: :create
  validates_presence_of :email, on: :create  
  validates_uniqueness_of :email
<<<<<<< HEAD

=======
>>>>>>> 84aef86727a9f8443bd6ac6e992193f6ae8bc6d5
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
<<<<<<< HEAD
        url = url.attrs[:expanded_url] 
        sharer = tweet.user.screen_name
        { url: url, sharer: sharer }
=======
        url       = url.attrs[:expanded_url] 
        shared_by = tweet.user.screen_name
        { url: url, shared_by: shared_by }
>>>>>>> 84aef86727a9f8443bd6ac6e992193f6ae8bc6d5
      end  
    end
    links.compact.delete_if { |link| #regex domain is in?
      link[:url].empty? || 
      link[:url].include?('youtu.be') ||
      link[:url].include?('youtube.com') || 
      link[:url].include?('pinterest.com') ||
      link[:url].include?('pin.it') ||
      link[:url].include?('vimeo.com') ||
      link[:url].include?('twitpic.com') ||
      link[:url].include?('instagram.com') ||
<<<<<<< HEAD
      link[:url].include?('login') ||
      link[:url].include?('shop') }
  end

end
=======
      link[:url].include?('video') ||
      link[:url].include?('vine.co') }
  end

end

>>>>>>> 84aef86727a9f8443bd6ac6e992193f6ae8bc6d5
=begin
blacklist: youtu.be, youtube.com, pin.it, pinterest.com, ow.ly,
=end

=begin
whitelist: slate.com, slate.me, wsj.com, bit.ly, vogue.cm, esqm.ag, esquire.com, vogue.com, on.mash, nytimes.com, nyti.ms, read.bi

=end
