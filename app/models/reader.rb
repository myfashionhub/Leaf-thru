class Reader < ActiveRecord::Base
has_many :articles
has_many :publications

  authenticates_with_sorcery!

  validates_presence_of :password, on: :create
  validates_presence_of :email, on: :create
  validates_uniqueness_of :email

  #validates :email, email: true
  validates :password, length: {within: 6..16, wrong_length: "Password length does not match requirement"}, :on => :create
  before_save :downcase_email

  has_many :reader_article_joins
  has_many :articles, through: :reader_article_joins


  def downcase_email
    self.email.downcase!
  end

  def self.twitter_feed(tweets)
    links = tweets.map do |tweet|
      url    = tweet.urls[0]
      if url.nil? == false
        url = url.attrs[:expanded_url]
        sharer = tweet.user.screen_name
        { url: url, sharer: sharer }
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
      link[:url].include?('login') ||
      link[:url].include?('shop') }
  end



end

=begin
blacklist: youtu.be, youtube.com, pin.it, pinterest.com, ow.ly,
=end

=begin
whitelist: slate.com, slate.me, wsj.com, bit.ly, vogue.cm, esqm.ag, esquire.com, vogue.com, on.mash, nytimes.com, nyti.ms, read.bi

=end
