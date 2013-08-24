class ReservationsController < ApplicationController
  include Wservices
	before_action  :logged_in?
	
  def new
  end

  def index
    current_and_future = get_current_and_future_reservations
    if current_and_future.has_key?(:current)
      @current = current_and_future[:current]
    else
      @current = nil
    end

    if current_and_future.has_key?(:future)
      @future = current_and_future[:future]
    else
      @future = nil
    end

    #@current_reservation = get_current_and_future_reservations
    #@future = get_current_and_future_reservations
    #@current_reservation = get_current_and_future_reservations
    #@hash = vehicle_by_id(1)
    #@stack = availability_for_stack("55",Time.now.to_i.to_s, (Time.now.to_i + 3600).to_s)
    #@check = check_reservation_date_time("1377360000")
    #@stack_filter = results_from_stack_filter("1","2")
  end

	private
		def logged_in?
			redirect_to root_path unless is_logged_in?
		end
end
