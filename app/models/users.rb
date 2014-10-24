class Users < ActiveRecord::Base
	has_many :problems
	has_many :notes
end
