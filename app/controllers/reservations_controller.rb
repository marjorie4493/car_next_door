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
      @view = get_driver_messages
    end

  end

  def new 
    #search cars for the user to reserve
    #just displaying all vehicle types for now
    @vehicle_array = all_vehicle_types
    @amenities = amenities
    Time.zone = get_time_zone
    @time = Time.zone
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
      if(Time.now.at_end_of_day - Time.now).to_i / 60 <15
        @date = Date.current + 1.day
      else
        @date = Date.current
      end
      @times = Array
    end
      @times = Array.new(24.hours / 15.minutes) do |i|
      (Time.now.midnight + (i*15.minutes)).strftime("%I:%M %p")
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
  
  # Extends a current reservation
  def extend
    unless reservation_with_id(params[:id]).nil?
      @reservation = reservation_with_id(params[:id])
	  
	  @start_time = Time.at(@reservation[:start_time].to_i).strftime("%I:%M %p %d/%m/%Y")
	  @end_time = Time.at(@reservation[:end_time].to_i).strftime("%I:%M %p %d/%m/%Y")
	  
	   if (Time.now.at_end_of_day - Time.now).to_i / 60 < 15
		@date = Date.current + 1.day
		else
		@date = Date.current
		end
		@times = Array.new(24.hours / 15.minutes) do |i|
		  (Time.now.midnight + (i*15.minutes)).strftime("%I:%M %p")
		end
	end
	if !params[:end_date].nil? && !params[:end_time].nil?
	end_date1 = DateTime.strptime(params[:end_date], "%Y-%m-%d")
	end_time1 = DateTime.strptime(params[:end_time], "%I:%M %p")
	end_date_time = DateTime.new(end_date1.year, end_date1.month, end_date1.day, end_time1.hour, end_time1.min).to_i
	# if extend_reservation_with_id(params[:id], end_date_time)
	  # redirect_to reservation_view_path(params[:id])
	# end	
	end
  end

	private
		def logged_in?
			redirect_to root_path unless is_logged_in?
		end
end
