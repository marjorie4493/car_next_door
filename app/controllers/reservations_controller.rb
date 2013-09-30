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

   @past = past_reservations

  end

  def view
    unless reservation_with_id(params[:id]).nil?
      @reservation = reservation_with_id(params[:id])
	  Time.zone = get_time_zone
      @time = Time.zone
	  
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
    @locations = get_driver_locations
    @location_array = []
    @location_array.append(@locations[:description])
    @qtr_time = (time_to_next_quarter_hour(Time.now + 15.minutes)).strftime("%I:%M %p")
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
  
  def cancel
    cancel_reservation_with_id(params[:id])
    redirect_to reservation_confirm_path
  end

  def edit
    unless reservation_with_id(params[:id]).nil?
      uid = params[:id]
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

    if !params[:"start-date"].nil? && !params[:"start-time"].nil? && !params[:"end-date"].nil? && !params[:"end-time"].nil?
    Time.zone = get_time_zone
    start_date1 = DateTime.strptime(params[:"start-date"], "%Y-%m-%d")
    start_time1 = DateTime.strptime(params[:"start-time"], "%I:%M %p")
    start_date_time = Time.new(start_date1.year, start_date1.month, start_date1.day, start_time1.hour, start_time1.min).to_i
    Time.zone = get_time_zone
    start_date_time1 = Time.zone.at(start_date_time).to_i

    end_date1 = DateTime.strptime(params[:"end-date"], "%Y-%m-%d")
    end_time1 = DateTime.strptime(params[:"end-time"], "%I:%M %p")
    end_date_time = Time.new(end_date1.year, end_date1.month, end_date1.day, end_time1.hour, end_time1.min).to_i
     Time.zone = get_time_zone
    end_date_time1 = Time.zone.at(end_date_time).to_i

    result = edit_reservation_times(uid.to_s,start_date_time1.to_s,end_date_time1.to_s)

    if result == "1"
      redirect_to reservation_view_path(:id => uid), { "data-ajax" => "false" }
    else
    # Error
      @error = result["fault"][0]["value"][0]["struct"][0]["member"][1]["value"][0]["string"][0]
    end 
  end

 end
  
  # Extends a current reservation
  def extend
    unless reservation_with_id(params[:id]).nil?
      @reservation = reservation_with_id(params[:id])
    
    # Current reservation times
    @start_time_string = Time.at(@reservation[:start_time].to_i).strftime("%I:%M %p %d/%m/%Y")
    @end_time = Time.at(@reservation[:end_time].to_i)
    end_date = @end_time.to_date
    @end_time_string = @end_time.strftime("%I:%M %p %d/%m/%Y")
    
    # Determines selection options
     if (@end_time.at_end_of_day - @end_time).to_i / 60 < 15
    @date = end_date + 1.day
    else
    @date = end_date
    end
    @times = Array.new(24.hours / 15.minutes) do |i|
      (Time.now.midnight + (i*15.minutes)).strftime("%I:%M %p")
    end
  end
  
    # Extend reservation using users input
    if !params[:end_date].nil? && !params[:end_time].nil?
      end_date1 = DateTime.strptime(params[:end_date], "%Y-%m-%d")
      end_time1 = DateTime.strptime(params[:end_time], "%I:%M %p")
      end_date_time = Time.new(end_date1.year, end_date1.month, end_date1.day, end_time1.hour, end_time1.min).to_i
      Time.zone = get_time_zone
      end_date_time1 = Time.zone.at(end_date_time).to_i
      extended = extend_reservation_with_id(params[:id].to_s, end_date_time1.to_s)
      if extended == "1"
        redirect_to reservation_view_path(:id => params[:id]), { "data-ajax" => "false" }
      else
      # Error
        @result = extended["fault"][0]["value"][0]["struct"][0]["member"][1]["value"][0]["string"][0]
      end 
    end
  end
  
  # End a current reservation early
  def early
    unless reservation_with_id(params[:id]).nil?
      @reservation = reservation_with_id(params[:id])
    
    # Current reservation times
    @start_time_string = Time.at(@reservation[:start_time].to_i).strftime("%I:%M %p %d/%m/%Y")
    @end_time = Time.at(@reservation[:end_time].to_i)
    @end_time_string = @end_time.strftime("%I:%M %p %d/%m/%Y")
    
    # Determines selection options
    if (Time.now.at_end_of_day - Time.now).to_i / 60 < 15
      @date = Date.current + 1.day
    else
      @date = Date.current
    end
    
    @times = Array.new(24.hours / 15.minutes) do |i|
      (Time.now.midnight + (i*15.minutes)).strftime("%I:%M %p")
    end
  end
  
  # End early a reservation using users input
    if !params[:end_date].nil? && !params[:end_time].nil?
      end_date1 = DateTime.strptime(params[:end_date], "%Y-%m-%d")
      end_time1 = DateTime.strptime(params[:end_time], "%I:%M %p")
      end_date_time = Time.new(end_date1.year, end_date1.month, end_date1.day, end_time1.hour, end_time1.min).to_i
      Time.zone = get_time_zone
      end_date_time1 = Time.zone.at(end_date_time).to_i
      ended_early = early_return_for_reservation_with_id(params[:id].to_s, end_date_time1.to_s)
      if ended_early == "1"
        redirect_to reservation_view_path(:id => params[:id]), { "data-ajax" => "false" }
      else
      # Error
        @result = ended_early["fault"][0]["value"][0]["struct"][0]["member"][1]["value"][0]["string"][0]
      end 
    end
  end

  def search
    if !params[:start_date].nil?
      @start_date = params[:start_date]
    end
    @start_time = params[:start_time]
    @end_date = params[:end_date]
    @end_time = params[:end_time]
    @vehicles = params[:vehicles]
    @amenities = params[:amenity]
  end

  def cancel
    cancel_reservation_with_id(params[:id])
    redirect_to reservation_confirm_path
  end
  def book
    start_date = DateTime.strptime(params[:start_date], "%Y-%m-%d")
    start_time = DateTime.strptime(params[:start_time], "%I:%M %p")
    end_date = DateTime.strptime(params[:end_date], "%Y-%m-%d")
    end_time = DateTime.strptime(params[:end_time], "%I:%M %p")
    @start_date_time = Time.new(start_date.year, start_date.month, start_date.day, start_time.hour, start_time.min).to_i
    @end_date_time = Time.new(end_date.year, end_date.month, end_date.day, end_time.hour, end_time.min).to_i
    id = make_reservation_get_id(56, @start_date_time, @end_date_time, '')
    redirect_to reservation_view_path(:id => id)
  end

	private
		def logged_in?
			redirect_to root_path unless is_logged_in?
		end
end
