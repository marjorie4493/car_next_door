class UsersController < ApplicationController
	include Wservices
	before_action  :logged_in?
	
	def profile
		# @name = get_driver_name
		@driversThings = get_drivers_interesting_things
		@driverConfig = get_other_driver_account_type
	end
  
	def logged_in?
		redirect_to root_path unless is_logged_in?
	end
end
