require "digest"

class User < ApplicationRecord
  has_one :wallet, as: :owner, dependent: :destroy
  before_create :generate_auth_token

  def set_password(raw_password)
    self.password = Digest::SHA256.hexdigest(raw_password)
  end

  def authenticate(raw_password)
    Digest::SHA256.hexdigest(raw_password) == self.password
  end

  # Generate token dengan expiration (default: 24 jam)
  def generate_auth_token(expiration_hours = 2)
    self.token = SecureRandom.hex(20)
    self.expires_at = Time.current + expiration_hours.hours
  end

  # Cek apakah token masih berlaku
  def token_valid?
    expires_at && expires_at > Time.current
  end
end
