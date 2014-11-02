require "#{Rails.root}/lib/twitter"

class Reader < ActiveRecord::Base
  has_many :subscriptions
  has_many :publications, through: :subscriptions
  has_many :bookmarks
  has_many :articles, through: :bookmarks

  authenticates_with_sorcery!

  validates_presence_of :password, on: :create
  validates_presence_of :email, on: :create
  validates_uniqueness_of :email

  validates :password,
            length: {
              within: 6..20,
              wrong_length: "Password must be between 6-20 characters"
            },
            :on => :create
  before_save :downcase_email

  def self.twitter_feed(token, token_secret)
    tweets = Twitter.get_feed(token, token_secret)
    links = Twitter.collect_links(tweets)
    links = Twitter.filter_sources(links)
    articles = Article.parse(links)
  end

  def self.rss_feed
  end

  # Helper methods
  def downcase_email
    self.email.downcase!
  end

  def self.validate_password(password)
    if password.match(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/)
      return true
    else
      flash[:notice] = "Password must be between 6 to 20 characters, contain one capital letter, and one number."
      return false
    end
  end

  def self.validate_email(email)
    if email.match(/^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/)
      return true
    else
     flash[:alert] = "Invalid email."
     return false
    end
  end

end
