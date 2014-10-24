class User < ActiveRecord::Base
	has_many :problems
	has_many :notes
end
