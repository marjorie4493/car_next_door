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
  end

  def view
    unless reservation_with_id(params[:id]).nil?
      @reservation = reservation_with_id(params[:id])
    end
  end

	private
		def logged_in?
			redirect_to root_path unless is_logged_in?
		end
end
