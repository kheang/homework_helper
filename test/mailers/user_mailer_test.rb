require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
	test "account_activation" do
		user = users(:one)
		mail = UserMailer.account_activation(user.id)
		assert_equal "User verification for I Need Help!", mail.subject
		assert_equal [user.email], mail.to
		assert_equal ["no-reply@example.com"], mail.from
		assert_match "Hello", mail.body.encoded
	end
end
