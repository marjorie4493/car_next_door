class ReservationsController < ApplicationController
  include Wservices
	before_action  :logged_in?
	

  def index

    # get current and future user reservations for display on index
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
  end

  def view
    unless reservation_with_id(params[:id]).nil?
      @reservation = reservation_with_id(params[:id])
      # for showing on map, this returns a latitude and longitude which can be used for mapping

      @stack = stack_for_id(@reservation[:stack_id], @reservation[:start_time])
    end

  end

  def new 
    #search cars for the user to reserve
    #just displaying all vehicle types for now
    @vehicle_array = all_vehicle_types
    if (Time.now.at_end_of_day - Time.now).to_i / 60 < 15
      @date = Date.current + 1.day
    else
      @date = Date.current
    end
    @times = Array.new(24.hours / 15.minutes) do |i|
      (Time.now.midnight + (i*15.minutes)).strftime("%I:%M %p")
    end
  end

  def edit
    unless reservation_with_id(params[:id]).nil?
      @reservation = reservation_with_id(params[:id])
    end
    
  end

  def update
    #  Still fixing the layout
       @reservation = reservation_with_id(params[:id])
      if edit_reservation_times(params[:reservation][:id],params[:reservation][:start_time],params[:reservation][:end_time])
        redirect_to reservations_view_path
      else
        render "edit" 
      end
 
  end

	private
		def logged_in?
			redirect_to root_path unless is_logged_in?
		end
end
