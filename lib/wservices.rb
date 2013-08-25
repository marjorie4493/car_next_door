require 'xmlsimple'
require 'net/http'
module Wservices
  # Returns a list of available times for availability for the specified stack.
  def availability_for_stack(stack_id, start_time, end_time)
    method = "availabilityForStack&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time
    post_request(method)
  end

  # Returns the divisor in minutes that a reservation start and end time must # fall on. Start and End time must be divisible by this number.
  def trip_time_resolution
    method = "tripTimeResolution"
    post_request(method)
  end

  # Returns an estimate structure for the given time frame, stack and driver.
  def trip_estimate(stack_id, start_time, end_time)
    method = "tripEstimate&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time
    post_request(method)
  end

  def trip_estimate_and_optional_adjustments(stack_id, start_time, end_time)
    method = "tripEstimateAndOptionalAdjustments&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time
    post_request(method)
  end

  # Returns an estimate structure for the given reservation for the given      # timeframe, stack and driver.
  def trip_estimate_for_reservation_with_id(reservation_id, stack_id, start_time, end_time)
    method = "tripEstimateForReservationWithId&reservationId=" + reservation_id + "&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time
    post_request(method)
  end

  # Reserves a vehicle in a stack for this member at the specified time. Will # return true if all was successful or an exception if not.
  def make_reservation(stack_id, start_time, end_time, memo)
    method = "makeReservation&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time + "&memo=" + memo
    post_request(method)
  end

  # Reserves a vehicle in a stack for this member at the specified time.       # Will return the id of the reservation if all was sucessful or exception   # if not.
  def make_reservation_get_id(stack_id, start_time, end_time, memo)
    method = "makeReservationGetId&stackId=" + stack_id + "&startTime=" + start_time + "&memo=" + memo
    post_request(method)
  end

  # Reserves a vehicle in a stack for this member at the specified time. Will  # return the reservation if all was successful, other exception. 
  def make_reservation_get_reservation(stack_id, start_time, end_time, memo)
    method = "makeReservationGetReservation&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time + "&memo=" + memo
    post_request(method)
  end

  # Reserves a vehicle in a stack for this member at the specified time,      # assigning any optional adjustments by id that were specified. 
  def make_reservation_with_optional_adjustment_ids(stack_id, start_time, end_time, optional_adjustment_ids, memo)
    method = "makeReservationWithOptionalAdjustmentIds&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time + "optionalAdjustmentIds=" + optional_adjustment_ids + "&memo=" + memo
    post_request(method)
  end

  # Reserves a vehicle in a stack for this member at the specified time,      # assigning any optional adjustments by id that were specified.
  def make_reservation_with_optional_adjustment_ids_get_ids(stack_id, start_time, end_time, optional_adjustment_ids, memo)
    method = "makeReservationWithOptionalAdjustmentIdsGetIds&stackId=" + stack_id + "&startTime=" + start_time + "&end_time=" + end_time + "optionalAdjustmentIds=" + optional_adjustment_ids + "&memo=" + memo
    post_request(method)
  end

  # Reserves a vehicle in a stack for this member at the specified time,
  # assigning any optional adjustments by id that were specified. Will
  # return the reservation if all was successful.
  def make_reservation_with_optional_adjustment_ids_get_reservation(stack_id, start_time, end_time, optional_adjustment_ids, memo)
    method = "makeReservationWithOptionalAdjustmentIdsGetReservation&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time + "&optionalAdjustmentIds=" + optional_adjustment_ids + "&memo=" + memo
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
    post_request(method)
  end

  # Check if your specified time is acceptable for the start or end time of 
  # a reservation, throws exception if not.
  def check_reservation_date_time(stamp)
    method = "checkReservationDateTime&stamp=" + stamp
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
    end
    reservation
  end

  # Extends a reservation with the specified ID until the specified date time.
  # Returns true if successful, throws exception if not.
  def extend_reservation_with_id(reservation_id, end_time)
    method = "extendReservationWithId&reservationId=" + reservation_id + "&endTime=" + end_time
    post_request(method)
  end

  # Extends a reservation with the specified ID until the specified date time.
  # returns reservation on succes, throws exception if not. 
  def extend_reservation_with_id_get_reservation(reservation_id, end_time)
    method = "extendReservationWithIdGetReservation&=" + reservation_id + "&endTime=" + end_time
    post_request(method)
  end

  # Shortens the end time of a reservation with the specified ID until the
  # specified date time. Returns true on success, throws exception if not.
  def early_return_for_reservation_with_id(reservation_id, end_time)
    method = "earlyReturnForReservationWithId&reservationId=" + reseveration_id + "&endTime=" + end_time
    post_request(method)
  end

  # Shortens the end time of a reservation with the specified ID until the
  # specified date time. Returns reservation on success, throws exception if 
  # not.
  def early_return_for_reservation_with_id_get_reservation(reservation_id, end_time)
    method = "earlyReturnForReservationWithIdGetReservation&=" + reservation_id + "&endTime=" + end_time
    post_request(method)
  end

  # Shortens the start time of a reservation with the specified ID until the
  # specified date time. Returns true on success 
  def early_arrive_for_reservation_with_id(reservation_id, start_time)
    method = "earlyAriveForReservationWithId&=" + reservation_id + "&startTime=" + start_time
  end

  # Shortens the start time of a reservation with the specified ID, until the 
  # specified date time. Returns reservation on success, throws exception if
  # not.
  def early_arrive_for_reservation_with_id_get_reservation(reservation_id, start_time)
    method = "earlyAriveForReservationWithIdGetReservation&reservationId=" + reservation_id + "&startTime=" + start_time
    post_request(method)
  end

  # Edits the reservation times of the reservation with the specified ID, 
  # returns true on success, throws exception if not.
  def edit_reservation_times(reservation_id, start_time, end_time)
    method = "editReservationTimes&reservationId=" + reservation_id + "&startTime=" + start_time + "&endTime=" + end_time
    post_request(method)
  end

  # Edits the reservation times of the reservation with the specified ID,
  # returns reservation on success, throws exception if not. 
  def edit_reservation_times_get_reservation(reservation_id, start_time, end_time)
    method = "editReservationTimesGetReservation&reservationId=" + reservation_id + "&startTime=" + start_time + "&endTime=" + end_time
    post_request(method)
  end

  # Returns all valid vehicle types
  def all_vehicle_types
    method = "allVehicleTypes"
    hash = post_request(method)

    # breaks down big hash of cars into hashes 
    vehicles = hash["DBEntityVehicleType"]
    vehicle_array = []

    if !hash["DBEntityVehicleType"][0].nil?
      vehicles.each { |x| 
        vehicle_array.push( { :descr => x["descr"][0],
                           :longDescr => x["longDescr"][0],
                           :id => x["id"][0],
                           :thumbDest => x["thumbDest"][0],
                           :imageDest => x["imageDest"][0],
                           :usage => x["usage"][0]} ) 
      }
    end
    vehicle_array
  end

  # Returns the phone number of the call center.
  def client_phone
    method = "clientPhone"
    post_request(method)
  end

  # Returns the available amenities for vehicles.
  def amenities
    method = "amenities"
    post_request(method)
  end

  # Filters results
  def results_from_stack_filter(a_stack_filter, include_stack)
    #method = "resultsFromStackFilter&aStackFilter=" + a_stack_filter + "&includeStack=" + include_stack
    sf = "aStackFilter%5B0%5D=0&aStackFilter%5B1%5D=0&aStackFilter%5B2%5D=0&aStackFilter%5B3%5D=&aStackFilter%5B4%5D=1377352800&aStackFilter%5B5%5D=1377360000&aStackFilter%5B6%5D=1&aStackFilter%5B7%5D=1&aStackFilter%5B8%5D=&aStackFilter%5B9%5D=0"

    sf3 = "aStackFilter%5B%5D=0&aStackFilter%5B%5D=0&aStackFilter%5B%5D=0&aStackFilter%5B%5D=&aStackFilter%5B%5D=1377352800&aStackFilter%5B%5D=1377360000&aStackFilter%5B%5D=1&aStackFilter%5B%5D=1&aStackFilter%5B%5D=&aStackFilter%5B%5D=0"

    sf4 = "aStackFilter[]=&aStackFilter[]=&aStackFilter[]=&aStackFilter[]=&aStackFilter[]=1377352800&aStackFilter[]=13773600001&aStackFilter[]=1&aStackFilter[]=1&aStackFilter[]=&aStackFilter[]="

    method = "resultsFromStackFilter&"+ sf4 +"&includeStack=false"
    post_request(method)
  end

  # Gets the clients timezone
  def get_time_zone
    method = "getTimeZone"
    post_request(method)
  end

  # Returns a DBEntityStack for the specified Stack ID. 
  def stack_for_id(stack_id, time)
    method = "stackForId&stackId=" + stack_id + "&time=" + time
    post_request(method)
  end

  # Returns array containing locale information for the client.
  def get_locale
    method = "getLocale"
    post_request(method)
  end

  # Returns an array of driver locations.
  def get_driver_locations
    method = "getDriverLocations"
    post_request(method)
  end

  # Return the driver's name.
  def get_driver_name
    method = "getDriverName"
    post_request(method)
  end

  # Cancel a reservation for this user.
  def cancel_reservation_with_id(reservation_id)
    method = "cancelReservationWithId&reservationId=" + reservation_id
    post_request(method)
  end

  # Cancel a reservation for this user, return reservation.
  def cancel_reservation_with_id_get_reservation(reservation_id)
    method = "cancelReservationWithIdGetReservation&reservationId=" + reservation_id
    post_request(method)
  end

  # Returns user configuration.
  def get_configuration
    method = "getConfiguration"
    post_request(method)
  end

  # returns a set of interesting things about this driver.
  def get_drivers_interesting_things
    method = "getDriversIntrestingThings"
    post_request(method)
  end

  # Returns future and current reservations.
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
        future_array.push( { :start_time => Time.zone.at(x["startStamp"][0].to_i),
                             :end_time => Time.zone.at(x["endStamp"][0].to_i),
                             :id => x["id"][0],
                             :estimate => x["estimate"][0],
                             :location => x["DBEntityStack"][0]["lotDescription"][0],
                             :status => x["status"][0],
                             :vehicle_id => x["DBEntityStack"][0]["DBEntityVehicleType"][0]["id"][0] } ) 
      }
      result[:future] = future_array
    end
    result 
  end

  # Returns an array of messages for the logged in driver.
  def get_driver_messages
    method = "getDriverMessages"
    post_request(method)
  end

  # Returns the drivers reservations and messages.
  def get_current_and_future_reservations_and_driver_messages
    method = "getCurrentAndFutureReservationsAndDriverMessages"
    post_request(method)
  end

  # Returns an array of messages for the specified reservation.
  def get_reservation_messages(reservation_id)
    method = "getReservationMessages&reservationId=" + reservation_id
    post_request(method)
  end

  # Returns an array of messages for the specified stack. These 
  # messages include stack, vehicle and lot messages.
  def get_stack_messages(stack_id, start_time)
    method = "getStackMessages&stackId=" + stack_id + "&startTime=" + start_time
    post_request(method)
  end

  # Returns whether the logged in driver has a linked driver.
  def has_linked_driver
    method = "hasLinkedDriver"
    post_request(method)
  end

  # Check whether the logged in driver has a linked driver and returns
  # a text description of the other driver's account type.
  def get_other_driver_account_type
    method = "getOtherDriverAccountType"
    post_request(method)
  end

  # Return all the valid problem types that this memeber can enter.
  def all_member_problem_types
    method = "allMemberProblemTypes"
    post_request(method)
  end

  # Submit a problem for this driver.
  def submit_problem(problem_type, reservation_id, message)
    method = "submitProblem&problemType=" + problem_type + "&reservationId=" + reservation_id + "&message=" + message
    post_request(method)
  end

  # Allows you to start trip.
  def start_trip_by_id(trip_id)
    method = "startTripById&tripId=" + trip_id
    hash = post_request(method)
  end

  # Sets the end time and end odo or a trip id.
  def end_trip_by_id(trip_id, end_odo)
    method = "endTripById&tripId=" + trip_id + "&endOdo=" + end_odo
    post_request(end_odo)
  end

  # Returns a vehicle from the vehicle id.
  def vehicle_by_id(vehicle_id)
    method = "vehicleById&vehicleId=" + vehicle_id.to_s
    hash = post_request(method)
    #hash["DBEntityVehicle"][0]
  end

  # Get locale of driver.
  def get_driver_language_locale
    method = "getDriverLanguageLocale"
    post_request(method)
  end

  # Mark message as read.
  def mark_read_once_message_as_read(message_id)
    method = "markReadOnceMessageAsRead&messageId=" + message_id
    post_request(method)
  end

  # Returns configuration details if supplied authentication information 
  # is correct.
  def is_logged_in_get_configuration
    method = "isLoggedInGetConfiguration"
    post_request(method)
  end

  # Get class.
  def get_class
    method = "getClass"
    post_request(method)
  end

  # Calls API and returns result in xml. 
  def post_request(method)
    time =  Time.now.to_i.to_s
    hash_method = method.split('&').first
    username = cookies.signed[:username].to_s
    password = cookies.signed[:pwd]
    hash = Digest::SHA1.hexdigest(password + time + hash_method)
    uri = URI.parse("https://reserve.carnextdoor.com.au/webservices/index.php/WSUser/WSRest?action=" + method + "&user=" + username + "&hash=" + hash + "&time=" + time + "&billcode=mobile")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)

    response = http.request(request)
    hash = XmlSimple.xml_in(response.body, { 'KeyAttr' => 'name'})
    #hash = Hash.from_xml response.body
  end

  def post_request3(method)
  time =  Time.now.to_i.to_s
  hash_method = method.split('&').first
  username = cookies.signed[:username].to_s
  password = cookies.signed[:pwd]
  hash = Digest::SHA1.hexdigest(password + time + hash_method)
  http = Curl::Easy::http_post("https://reserve.carnextdoor.com.au/webservices/index.php/WSUser/WSRest?action=" + method + "&user=" + username + "&hash=" + hash + "&time=" + time + "&billcode=mobile")
  hash = XmlSimple.xml_in(http.body_str, { 'KeyAttr' => 'name'})
  end

end