class ReservationsController < ApplicationController
  include Wservices
	before_action  :logged_in?
	
  def index
    @vehicle = get_drivers_interesting_things
    @config = get_configuration
  end

	private
		def logged_in?
			redirect_to root_path unless is_logged_in?
		end
end
