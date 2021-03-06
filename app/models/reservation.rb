class Reservation
  include ActiveModel::Model
  include Post

  def initialize(user_details)
    @username = user_details[:username].to_s
    @password = user_details[:password].to_s
  end

  def get_time_zone
    method = "getTimeZone"
    post_request(method)
  end

  # Returns the divisor in minutes that a reservation start and end time must # fall on. Start and End time must be divisible by this number.
  def trip_time_resolution
    method = "tripTimeResolution"
    post_request(method)
  end

  # Returns an estimate structure for the given time frame, stack and driver.
  def trip_estimate(stack_id, start_time, end_time)
    method = "tripEstimate&stackId=" + stack_id.to_s + "&startTime=" + start_time.to_s + "&endTime=" + end_time.to_s
    post_request(method)
  end

  def trip_estimate_and_optional_adjustments(stack_id, start_time, end_time)
    method = "tripEstimateAndOptionalAdjustments&stackId=" + stack_id.to_s + "&startTime=" + start_time.to_s + "&endTime=" + end_time.to_s
    post_request(method)
  end

  # Returns an estimate structure for the given reservation for the given      # timeframe, stack and driver.
  def trip_estimate_for_reservation_with_id(reservation_id, stack_id, start_time, end_time)
    method = "tripEstimateForReservationWithId&reservationId=" + reservation_id.to_s + "&stackId=" + stack_id.to_s + "&startTime=" + start_time.to_s + "&endTime=" + end_time.to_s 
    post_request(method)
  end

  # Reserves a vehicle in a stack for this member at the specified time. Will # return true if all was successful or an exception if not.
  def make_reservation(stack_id, start_time, end_time, memo)
    method = "makeReservation&stackId=" + stack_id.to_s + "&startTime=" + start_time.to_s + "&endTime=" + end_time.to_s + "&memo=" + memo
    post_request(method)
  end

  # Reserves a vehicle in a stack for this member at the specified time.       # Will return the id of the reservation if all was sucessful or exception   # if not.
  def make_reservation_get_id(stack_id, start_time, end_time, memo)
    method = "makeReservationGetId&stackId=" + stack_id.to_s + "&startTime=" + start_time.to_s + "&endTime=" + end_time.to_s + "&memo=" + memo
    post_request(method)
  end

  # Reserves a vehicle in a stack for this member at the specified time. Will  # return the reservation if all was successful, other exception. 
  def make_reservation_get_reservation(stack_id, start_time, end_time, memo)
    method = "makeReservationGetReservation&stackId=" + stack_id.to_s + "&startTime=" + start_time.to_s + "&endTime=" + end_time.to_s + "&memo=" + memo
    post_request(method)
  end

  # Reserves a vehicle in a stack for this member at the specified time,      # assigning any optional adjustments by id that were specified. 
  def make_reservation_with_optional_adjustment_ids(stack_id, start_time, end_time, optional_adjustment_ids, memo)
    method = "makeReservationWithOptionalAdjustmentIds&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time + "optionalAdjustmentIds=" + optional_adjustment_ids + "&memo=" + memo
    post_request(method)
  end

  # Reserves a vehicle in a stack for this member at the specified time,      # assigning any optional adjustments by id that were specified.
  def make_reservation_with_optional_adjustment_ids_get_ids(stack_id, start_time, end_time, optional_adjustment_ids, memo)
    method = "makeReservationWithOptionalAdjustmentIdsGetIds&stackId=" + stack_id.to_s + "&startTime=" + start_time.to_s + "&end_time=" + end_time.to_s + "optionalAdjustmentIds=" + optional_adjustment_ids + "&memo=" + memo
    post_request(method)
  end

  # Reserves a vehicle in a stack for this member at the specified time,
  # assigning any optional adjustments by id that were specified. Will
  # return the reservation if all was successful.
  def make_reservation_with_optional_adjustment_ids_get_reservation(stack_id, start_time, end_time, optional_adjustment_ids, memo)
    method = "makeReservationWithOptionalAdjustmentIdsGetReservation&stackId=" + stack_id.to_s + "&startTime=" + start_time.to_s + "&endTime=" + end_time.to_s + "&optionalAdjustmentIds=" + optional_adjustment_ids + "&memo=" + memo
    post_request(method)
  end

  # Returns current reservation
  def current_reservation
    method = "currentReservation"
    post_request(method)
  end

  # Returns a set of future reservations
  def future_reservations
    method = "futureReservations"
    post_request(method)
  end

  # Returns a set of past reservations
  def past_reservations
    method = "pastReservations"
    hash = post_request(method)
    past_reservations = {}
    if !hash["DBEntityReservation"].nil?

      past = hash["DBEntityReservation"]
      past_array = []
      past.each { |x| 
        past_array.push(
           { :start_time  => Time.zone.at(x["startStamp"][0].to_i),
                             :end_time    => Time.zone.at(x["endStamp"][0].to_i),
                             :driver => x["DBEntityDriver"][0]["fullName"][0],
                             :id          => x["id"][0],
                             :estimate    => x["estimate"][0],
                             :location => x["DBEntityStack"][0]["locationDescription"][0],
                             :lot    => x["DBEntityStack"][0]["lotDescription"][0],
                             :status      => x["status"][0],
                             :image_url => x["DBEntityStack"][0]["DBEntityVehicleType"][0]["imageDest"][0],
                             :image_thumb_url => x["DBEntityStack"][0]["DBEntityVehicleType"][0]["thumbDest"][0],
                             :vehicle_id  => x["DBEntityStack"][0]["DBEntityVehicleType"][0]["id"][0], 
                             :stack_id => x["DBEntityStack"][0]["id"][0] })}
    else
      past_array = nil
    end
    past_array
  end

  # Check if your specified time is acceptable for the start or end time of 
  # a reservation, throws exception if not.
  def check_reservation_date_time(stamp)
    method = "checkReservationDateTime&stamp=" + stamp.to_s
    post_request(method)
  end

  # Returns a reservation for the logged in user with the specified ID.
  def reservation_with_id(reservation_id)
    method = "reservationWithId&reservationId=" + reservation_id.to_s
    hash = post_request(method)
    reservation = {}
    if !hash["DBEntityReservation"].nil?
      reservation_entity = hash["DBEntityReservation"][0]
      reservation[:id] = reservation_entity["id"][0]
      reservation[:start_time] = reservation_entity["startStamp"][0]
      reservation[:end_time] = reservation_entity["endStamp"][0]
      reservation[:driver] = reservation_entity["DBEntityDriver"][0]["fullName"][0]
      reservation[:location] = reservation_entity["DBEntityStack"][0]["locationDescription"][0]
      reservation[:estimate] = reservation_entity["estimate"][0]
      reservation[:image_url] = reservation_entity["DBEntityStack"][0]["DBEntityVehicleType"][0]["imageDest"][0]
      reservation[:image_thumb_url] = reservation_entity["DBEntityStack"][0]["DBEntityVehicleType"][0]["imageDest"][0]
      reservation[:vehicle_id] = reservation_entity["DBEntityStack"][0]["DBEntityVehicleType"][0]["id"][0]
      reservation[:stack_id] = reservation_entity["DBEntityStack"][0]["id"][0]
      reservation[:status] = reservation_entity["status"][0]
    else
      reservation = nil
    end
    reservation
  end

  # Extends a reservation with the specified ID until the specified date time.
  # Returns true if successful, throws exception if not.
  def extend_reservation_with_id(reservation_id, end_time)
    method = "extendReservationWithId&reservationId=" + reservation_id.to_s + "&endTime=" + end_time.to_s
    post_request(method)
  end

  # Extends a reservation with the specified ID until the specified date time.
  # returns reservation on succes, throws exception if not. 
  def extend_reservation_with_id_get_reservation(reservation_id, end_time)
    method = "extendReservationWithIdGetReservation&=" + reservation_id.to_s + "&endTime=" + end_time.to_s
    post_request(method)
  end

  # Shortens the end time of a reservation with the specified ID until the
  # specified date time. Returns true on success, throws exception if not.
  def early_return_for_reservation_with_id(reservation_id, end_time)
    method = "earlyReturnForReservationWithId&reservationId=" + reservation_id.to_s + "&endTime=" + end_time.to_s
    post_request(method)
  end

  # Shortens the end time of a reservation with the specified ID until the
  # specified date time. Returns reservation on success, throws exception if 
  # not.
  def early_return_for_reservation_with_id_get_reservation(reservation_id, end_time)
    method = "earlyReturnForReservationWithIdGetReservation&=" + reservation_id.to_s + "&endTime=" + end_time.to_s
    post_request(method)
  end

  # Shortens the start time of a reservation with the specified ID until the
  # specified date time. Returns true on success 
  def early_arrive_for_reservation_with_id(reservation_id, start_time)
    method = "earlyAriveForReservationWithId&=" + reservation_id.to_s + "&startTime=" + start_time.to_s
  end

  # Shortens the start time of a reservation with the specified ID, until the 
  # specified date time. Returns reservation on success, throws exception if
  # not.
  def early_arrive_for_reservation_with_id_get_reservation(reservation_id, start_time)
    method = "earlyAriveForReservationWithIdGetReservation&reservationId=" + reservation_id.to_s + "&startTime=" + start_time.to_s
    post_request(method)
  end

  # Edits the reservation times of the reservation with the specified ID, 
  # returns true on success, throws exception if not.
  def edit_reservation_times(reservation_id, start_time, end_time)
    method = "editReservationTimes&reservationId=" + reservation_id.to_s + "&startTime=" + start_time.to_s + "&endTime=" + end_time.to_s
    post_request(method)
  end

  # Edits the reservation times of the reservation with the specified ID,
  # returns reservation on success, throws exception if not. 
  def edit_reservation_times_get_reservation(reservation_id, start_time, end_time)
    method = "editReservationTimesGetReservation&reservationId=" + reservation_id.to_s + "&startTime=" + start_time.to_s + "&endTime=" + end_time.to_s
    post_request(method)
  end


  def get_current_and_future_reservations
    method = "getCurrentAndFutureReservations"
    hash = post_request(method)
    result = {}
    Time.zone = get_time_zone
    if !hash["WSGetCurrentAndFutureReservationsResult"][0]["DBEntityReservation"].nil? 
      current = hash["WSGetCurrentAndFutureReservationsResult"][0]["DBEntityReservation"][0]

      current_reservation = {}
      current_reservation[:start_time] = Time.zone.at(current["startStamp"][0].to_i)
      current_reservation[:end_time] = Time.zone.at(current["endStamp"][0].to_i)
      current_reservation[:id] = current["id"][0]
      current_reservation[:estimate] = current["estimate"][0]
      current_reservation[:location] = current["DBEntityStack"][0]["lotDescription"][0]
      current_reservation[:status] = current["status"][0]
      current_reservation[:vehicle_id] = current["DBEntityStack"][0]["DBEntityVehicleType"][0]["id"][0]
      result[:current] = current_reservation
    end
    
    if !hash["WSGetCurrentAndFutureReservationsResult"][0]["futureReservations"][0]["DBEntityReservation"].nil?
      future = hash["WSGetCurrentAndFutureReservationsResult"][0]["futureReservations"][0]["DBEntityReservation"]
      future_array = []
      future.each { |x| 
        future_array.push( { :start_time  => Time.zone.at(x["startStamp"][0].to_i),
                             :end_time    => Time.zone.at(x["endStamp"][0].to_i),
                             :id          => x["id"][0],
                             :estimate    => x["estimate"][0],
                             :location    => x["DBEntityStack"][0]["lotDescription"][0],
                             :status      => x["status"][0],
                             :vehicle_id  => x["DBEntityStack"][0]["DBEntityVehicleType"][0]["id"][0] } ) 
      }
      result[:future] = future_array
    end
    result 
  end

  def cancel_reservation_with_id(reservation_id)
    method = "cancelReservationWithId&reservationId=" + reservation_id.to_s
    post_request(method)
  end

  # Cancel a reservation for this user, return reservation.
  def cancel_reservation_with_id_get_reservation(reservation_id)
    method = "cancelReservationWithIdGetReservation&reservationId=" + reservation_id.to_s
    post_request(method)
  end

   # Returns the drivers reservations and messages.
  def get_current_and_future_reservations_and_driver_messages
    method = "getCurrentAndFutureReservationsAndDriverMessages"
    post_request(method)
  end

  # Returns an array of messages for the specified reservation.
  def get_reservation_messages(reservation_id)
    method = "getReservationMessages&reservationId=" + reservation_id.to_s
    post_request(method)
  end

  # Returns a DBEntityStack for the specified Stack ID. 
  def stack_for_id(stack_id, time)
    method = "stackForId&stackId=" + stack_id.to_s + "&time=" + time.to_s
    hash = post_request(method)
    
    stack = {}
    if !hash["DBEntityStack"].nil?
      stack_entity = hash["DBEntityStack"][0]
      stack[:descr] = stack_entity["DBEntityVehicleType"][0]["descr"][0]
      stack[:image] = stack_entity["DBEntityVehicleType"][0]["thumbDest"][0]
      stack[:id] = stack_entity["DBEntityVehicleType"][0]["id"][0]
      stack[:podFee] = stack_entity["podFee"][0]
      stack[:s_descr] = stack_entity["descr"][0]
      stack[:locationDescription] = stack_entity["locationDescription"][0]
      stack[:latitude] = stack_entity["latitude"][0]
      stack[:longitude] = stack_entity["longitude"][0]
    else
      stack = nil
    end
    stack
  end

  def availability_for_stack(stack_id, start_time, end_time)
    method = "availabilityForStack&stackId=" + stack_id.to_s + "&startTime=" + start_time.to_s + "&endTime=" + end_time.to_s
    hash = post_request(method)
    avail = hash["DBTimeSlot"]
    avail_array = []

    if(!avail.nil?)
      avail.each { |x|
        avail_array.push ( { :time      => x["time"][0],
                             :available => x["available"][0] } ) }
    end
    avail_array
  end

    # Filters results
  def results_from_stack_filter(a_stack_filter, include_stack)
    #method = "resultsFromStackFilter&aStackFilter=" + a_stack_filter + "&includeStack=" + include_stack
    #TODO - This is clearly not working and needs confirmation from metavera on how the arguments are passed.
    sf = "aStackFilter%5B0%5D=0&aStackFilter%5B1%5D=0&aStackFilter%5B2%5D=0&aStackFilter%5B3%5D=&aStackFilter%5B4%5D=1377352800&aStackFilter%5B5%5D=1377360000&aStackFilter%5B6%5D=1&aStackFilter%5B7%5D=1&aStackFilter%5B8%5D=&aStackFilter%5B9%5D=0"

    sf3 = "aStackFilter%5B%5D=0&aStackFilter%5B%5D=0&aStackFilter%5B%5D=0&aStackFilter%5B%5D=&aStackFilter%5B%5D=1377352800&aStackFilter%5B%5D=1377360000&aStackFilter%5B%5D=1&aStackFilter%5B%5D=1&aStackFilter%5B%5D=&aStackFilter%5B%5D=0"

    sf4 = "aStackFilter=&aStackFilter=&aStackFilter=&aStackFilter=&aStackFilter=1378123200&aStackFilter=1378137600&aStackFilter=tru&aStackFilter=true&aStackFilter=&aStackFilter="

    method = "resultsFromStackFilter&"+ sf4 +"&includeStack=false"
    post_request(method)
  end

  # Returns an array of messages for the specified stack. These 
  # messages include stack, vehicle and lot messages.
  def get_stack_messages(stack_id, start_time)
    method = "getStackMessages&stackId=" + stack_id.to_s + "&startTime=" + start_time.to_s
    hash = post_request(method)

    message_hash = hash["DBEntityMessage"][0]
    message = {}
    if !message_hash.nil?
      message[:descr] = message_hash["descr"][0]
      message[:text] = message_hash["text"][0]
      message[:priority] = message_hash["priority"][0]
      message[:priorityPk] = message_hash["priorityPk"][0]
      message[:priorityPktoValue] = message_hash["priorityPktoValue"][0]
      message[:id] = message_hash["id"][0]
    end
    message
  end

  # Submit a problem for this driver.
  def submit_problem(problem_type, reservation_id, message)
    method = "submitProblem&problemType=" + problem_type + "&reservationId=" + reservation_id.to_s + "&message=" + message
    post_request(method)
  end

  # Allows you to start trip.
  def start_trip_by_id(trip_id)
    method = "startTripById&tripId=" + trip_id
    hash = post_request(method)
  end

  # Sets the end time and end odo or a trip id.
  def end_trip_by_id(trip_id, end_odo)
    method = "endTripById&tripId=" + trip_id.to_s + "&endOdo=" + end_odo.to_s
    post_request(end_odo)
  end

  # Return all the valid problem types that this memeber can enter.
  def all_member_problem_types
    method = "allMemberProblemTypes"
    post_request(method)
  end

  # Submit a problem for this driver.
  def submit_problem(problem_type, reservation_id, message)
    method = "submitProblem&problemType=" + problem_type + "&reservationId=" + reservation_id.to_s + "&message=" + message
    post_request(method)
  end
end