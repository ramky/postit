require 'twilio-ruby' 

class User < ActiveRecord::Base
	include Sluggable

	has_many :posts
	has_many :comments
	has_many :votes

	has_secure_password validations: false
	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: {minimum: 5}

	sluggable_column :username

	def admin?
		self.role == 'admin'
	end

	def moderator?
		self.role == 'moderator'
	end

	def superuser?
		self.role == 'superuser'
	end
	
	def two_factor_auth?
	  !self.phone.blank?
  end
  
  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) # Random 6 digit number
  end
  
  def remove_pin!
    self.update_column(:pin, nil)
  end
  
  def send_pin_to_twilio
    account_sid = 'ACa1c3b69959b548ab5ee36dbaf8650459' 
    auth_token = 'e34d7bbd3ef0d25f95a21c006c64e187' 

    # set up a client to talk to the Twilio REST API 
    client = Twilio::REST::Client.new account_sid, auth_token 
    message = "Hi, please input this pin to continue with login: #{self.pin}"

    client.account.messages.create({
    	:from => '+14085330827',
    	:to   => '+14086605914',
    	:body => message  
    })
  end
end