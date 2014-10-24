class Users < ActiveRecord::Base
	has_many :problems
	has_many :notes

	validates :name,
            presence: true

	validates :email,
            presence: true,
	          uniqueness: { case_sensitive: false },
	          format: { with: /\A[\w\-\.]+@[\w\-\.]+\Z/, message: "must be a valid email address" }

	validates :password_digest,
            presence: true

	has_secure_password
end
