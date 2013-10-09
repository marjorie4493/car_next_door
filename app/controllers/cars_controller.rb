class CarsController < ApplicationController
  #include Wservices
	before_action  :logged_in?
	
  def index
    reservation = Reservation.new(user_credentials)
    @car = reservation.stack_for_id(56, Time.now.to_i)
    vehicle = Vehicle.new(user_credentials)
    car = vehicle.vehicle_by_id(@car[:id])
    @car_info = car[:info]
    @car_amenities = car[:amenities]
  end

  def reserve
    reservation = Reservation.new(user_credentials)
    @qtr_time = (time_to_next_quarter_hour(Time.now + 15.minutes)).strftime("%I:%M %p")
    Time.zone = reservation.get_time_zone
    @time = Time.zone
    if (Time.now.at_end_of_day - Time.now).to_i / 60 < 15
      @date = Date.current + 1.day
    else
      @date = Date.current
    end
    @times = Array.new(24.hours / 15.minutes) do |i|
      (Time.now.midnight + (i*15.minutes)).strftime("%I:%M %p")
    end
	

    @car = reservation.stack_for_id(56, Time.now.to_i)
	  vehicle = Vehicle.new(user_credentials)
    car = vehicle.vehicle_by_id(@car[:id])
    @car_info = car[:info]
    @car_amenities = car[:amenities]
  end
  
  def manage
    reservation = Reservation.new(user_credentials)
    @car = reservation.stack_for_id(56, Time.now.to_i)
    vehicle = Vehicle.new(user_credentials)
    car = vehicle.vehicle_by_id(@car[:id])
    @car_info = car[:info]
    @car_amenities = car[:amenities]
  end

  def details

  end

  def rates

  end

  def parking

  end

  def schedule

  end


  	private
		def logged_in?
			redirect_to root_path unless is_logged_in?
		end
end
