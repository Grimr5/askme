require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  REGEXP_EMAIL = /\A\w+@\w+(?:-\w+)?\.[A-Za-z]{2,4}+\z/.freeze
  REGEXP_USERNAME = /\A\w+\z/.freeze

  attr_accessor :password

  has_many :questions

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: REGEXP_EMAIL }
  validates :username, length: { maximum: 40 }
  validates :username, format: { with: REGEXP_USERNAME }
  validates :password, presence: true, on: :create
  validates :password, confirmation: true

  before_validation :downcase_username_and_email
  before_save :encrypt_password

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email&.downcase)

    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

  private

  def downcase_username_and_email
    username&.downcase!
    email&.downcase!
  end

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end
end
