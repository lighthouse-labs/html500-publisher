class User < ActiveRecord::Base

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true

  before_validation :downcase_creds

  def self.authenticate(attrs)
    # assumes all fields are required
    return User.new(attrs) if attrs.any? &:blank?

    # if login fails (nil), call register... beaute :) -KV
    login(attrs) || register(attrs)
  end

  protected

  def downcase_creds
    self.email.downcase! if self.email?
    self.username.downcase! if self.username?
    true
  end

  def self.login(attrs)
    User.where(email: attrs[:email].downcase, username: attrs[:username].downcase).first
  end

  def self.register(attrs)
    User.create(attrs)
  end

end