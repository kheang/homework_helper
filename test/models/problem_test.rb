require 'test_helper'

class ProblemTest < ActiveSupport::TestCase
  should validate_presence_of(:issue)
  should validate_presence_of(:try)
  should validate_presence_of(:user)

  should belong_to(:user)
  should have_many(:notes)
end
