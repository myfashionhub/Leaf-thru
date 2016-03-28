class Reader < ActiveRecord::Base
  has_many :subscriptions
  has_many :publications, through: :subscriptions
  has_many :bookmarks
  has_many :articles, through: :bookmarks

  authenticates_with_sorcery!

  validates_presence_of :password, on: :create
  validates_presence_of :email, on: :create
  validates_uniqueness_of :email

  validate  :valid_email
  validates :password,
            length: {
              within: 6..20,
              wrong_length: "Password must be between 6-20 characters"
            }

  def self.create_with_params(reader_params)
    reader  = Reader.new(reader_params)
    reader.image ||= 'assets/profile.svg'

    email    = reader_params[:email].downcase
    password = reader_params[:password]

    if reader.save
      {
        msg: 'Successfully signed up.', status: 'success',
        reader: reader.to_json
      }
    else
      { msg: reader.errors.first.join(' '), status: 'error' }
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


  private
  def valid_email
    if self.email.match(/^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/)
      true
    else
      self.errors.add(:email, 'is not valid')
      false
    end
  end

end
