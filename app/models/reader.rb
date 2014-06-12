class Reader < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_presence_of :password, on: :create
  validates_presence_of :email, on: :create  
  validates_uniqueness_of :email

  validates :email, email: true
  validates :password, length: {within: 6..16, wrong_length: "Password length does not match requirement"}, :on => :create

  before_save :downcase_email

  def downcase_email
    self.email.downcase!
  end 

end
