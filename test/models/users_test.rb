require 'test_helper'

class UsersTest < ActiveSupport::TestCase
	should validate_presence_of(:name)

	should validate_presence_of(:email)
	should validate_uniqueness_of(:email).case_insensitive
	should_not allow_value("BAD EMAIL").for(:email)
	should_not allow_value("@").for(:email)
	should_not allow_value("  example@example.com").for(:email)

	should have_secure_password

	# should have_many(:problems)
	# should have_many(:notes)
end
