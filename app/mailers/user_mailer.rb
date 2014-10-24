class UserMailer < ActionMailer::Base
  default from: "no-reply@example.com"

  def account_activation(id)
	  @user = User.find(id)
	  @greeting = "Hello #{@user.name}"
	  mail to: @user.email, subject: "User verification for Lab6"
  end
end
