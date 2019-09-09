class SecretCode < ApplicationRecord

	require "securerandom"

  belongs_to :user, optional: true
  validates_uniqueness_of :code

  scope :available,->{where("user_id is NUll")}

  attr_accessor :count

  self.per_page = 10

  COUNT_OPTIONS = [1,10,20,50,100]

  # => Generate and create secret codes
	def self.create_codes count
		codes = []
		count.times.each do |i|
			code = SecureRandom.uuid[0...6] 
			codes << SecretCode.create(code: code)
		end
		codes
  end

end
