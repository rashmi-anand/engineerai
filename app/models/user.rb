class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :secret_code

  after_create :update_secret_code, unless: -> {admin?}

  attr_accessor :uniq_code, :user_secret_code

  validate :check_secret_code, on: :create, unless: -> {admin?}

  # => Return full name of the user
  # => Eg. first: "Johny", last: "English"
  # => than it will return "Johny English"
  def full_name
  	[first, last].join(" ")
  end

  private

  # => Checks if user has entered the given secret code and
  # => if given secret record exits in table or not
  def check_secret_code
  	if uniq_code != user_secret_code
	  	errors.add(:user_secret_code, "entered the wrong code")
	  else
	  	@secret_code = SecretCode.find_by_code(user_secret_code)
	  	errors.add(:user_secret_code, "not available, request admin user for a new code") unless @secret_code
	  end

  end

  # => Callback to connect sign up user with the existing secret code
  def update_secret_code
  	sc = SecretCode.find_by_code(user_secret_code)
  	sc.update!(user_id: self.id)
	end
end
