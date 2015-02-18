class User < ActiveRecord::Base
  validates :name, :password_digest, :session_token, presence: true
  validates :name, :session_token, uniqueness: true

  after_initialize :ensure_session_token

  has_many :subs

  def self.find_by_credentials(user, password)
    user = User.find_by_name(user)
    if user.nil?
      return nil
    else
      user.is_password?(password) ? user : nil
    end
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def reset_session_token!
    self.session_token = generate_session_token
    self.save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end



  private

  def generate_session_token
    SecureRandom.urlsafe_base64
  end
end
