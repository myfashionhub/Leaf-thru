require "#{Rails.root}/lib/twitter"
require "#{Rails.root}/lib/google_feed"

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

  def self.create_reader(reader_params)
    reader  = Reader.new(reader_params)
    reader.image ||= 'assets/profile.svg'

    email    = reader_params[:email].downcase
    password = reader_params[:password]

    if Reader.find_by(email: email)
      msg = "Email already taken."
      status = 'error'
      { msg: msg, status: status }

    elsif Reader.validate_email(email) &&
      Reader.validate_password(password) && reader.save
      msg = 'Successfully signed up.'
      status = 'success'
      { msg: msg, status: status }
    
    elsif Reader.validate_email(email) != true
      Reader.validate_email(email)
      
    elsif Reader.validate_password(password) != true
      Reader.validate_password(password)
    end
  end

  def update_location(ip)
    location = ''
    geo = GeoIP.new("#{Rails.root}/db/GeoLiteCity.dat").city(ip)

    if geo.present?
      location = "#{geo.city_name}, #{geo.region_name}"
      self.update(location: location)
    end

    location
  end

  def self.twitter_feed(token, token_secret)
    tweets = Twitter.get_feed(token, token_secret)
    links = Twitter.collect_links(tweets)
    links = Twitter.filter_sources(links)
    articles = Article.parse(links)
  end

  def self.rss_feed(subscriptions)
    feed_urls = subscriptions.map do |subscription|
      id = subscription.publication_id
      publication = Publication.find(id)
      publication.url
    end
    articles = GoogleFeed.fetch_articles(feed_urls)
  end

  # Helper methods
  def self.validate_password(password)
    if password.length >= 6 && password.length <= 20
      #password.match(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,20}$/)
      return true
    else
      msg = "Password must be between 6 to 20 characters."
      status = 'error'
      return { msg: msg, status: status }
    end
  end

  def self.validate_email(email)
    if email.match(/^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/)
      return true
    else
     msg = "Invalid email."
     status = 'error'
     return { msg: msg, status: status }
    end
  end

end
