class ReservationsController < ApplicationController
  include Wservices
	before_action  :logged_in?
	
  def index
    @vehicle = vehicle_by_id(55)  
  end

	private

		def logged_in?
			redirect_to root_path unless is_logged_in?
		end
end
