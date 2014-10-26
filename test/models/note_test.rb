require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  should validate_presence_of(:comment)
  should validate_presence_of(:user)
  should validate_presence_of(:problem)

  should belong_to(:user)
  should belong_to(:problem)
end
