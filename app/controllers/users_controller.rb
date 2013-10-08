class UsersController < ApplicationController
	#include Wservices
	before_action  :logged_in?
	
	def profile
    user = User.new(user_credentials)
		@driversThings = user.get_drivers_interesting_things
	end
  
	def logged_in?
		redirect_to root_path unless is_logged_in?
	end
end
