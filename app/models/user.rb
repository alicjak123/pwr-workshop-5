class User < ActiveRecord::Base
	include BCrypt

	attr_accessor :password
	before_save :encrypt_password

  has_many :digs,     foreign_key: :owner_id, dependent: :destroy
  has_many :comments, foreign_key: :owner_id, dependent: :destroy
  has_many :votes,    foreign_key: :voter_id, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true, email: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :password, presence: true, on: :create

	def encrypt_password
		self.password_digest = BCrypt::Engine.generate_salt
		self.password_hash = BCrypt::Engine.hash_secret(password, password_digest)
	end
	def self.authenticate(email, password)
		user = User.where(email: email).first
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_digest)
			user
		else
			nil
		end
	end
end
