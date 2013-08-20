module Wservices
  def availability_for_stack(stack_id, start_time, end_time)
    method = "avaliabilityForStack&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time
    post_request(method)
  end

  def trip_time_resolution
    method = "tripTimeResolution"
    post_request(method)
  end

  def trip_estimate(stack_id, start_time, end_time)
    method = "tripEstimate&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time
    post_request(method)
  end

  def trip_estimate_and_optional_adjustments(stack_id, start_time, end_time)
    method = "tripEstimateAndOptionalAdjustments&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time
    post_request(method)
  end

  def trip_estimate_for_reservation_with_id(reservation_id, stack_id, start_time, end_time)
    method = "tripEstimateForReservationWithId&reservationId=" + reservation_id + "&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time
    post_request(method)
  end

  def make_reservation(stack_id, start_time, end_time, memo)
    method = "makeReservation&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time + "&memo=" + memo
    post_request(method)
  end

  def make_reservation_get_id(stack_id, start_time, end_time, memo)
    method = "makeReservationGetId&stackId=" + stack_id + "&startTime=" + start_time + "&memo=" + memo
    post_request(method)
  end

  def make_reservation_get_reservation(stack_id, start_time, end_time, memo)
    method = "makeReservationGetReservation&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time + "&memo=" + memo
    post_request(method)
  end

  def make_reservation_with_optional_adjustment_ids(stack_id, start_time, end_time, optional_adjustment_ids, memo)
    method = "makeReservationWithOptionalAdjustmentIds&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time + "optionalAdjustmentIds=" + optional_adjustment_ids + "&memo=" + memo
    post_request(method)
  end

  def make_reservation_with_optional_adjustment_ids_get_ids(stack_id, start_time, end_time, optional_adjustment_ids, memo)
    method = "makeReservationWithOptionalAdjustmentIdsGetIds&stackId=" + stack_id + "&startTime=" + start_time + "&end_time=" + end_time + "optionalAdjustmentIds=" + optional_adjustment_ids + "&memo=" + memo
    post_request(method)
  end

  def make_reservation_with_optional_adjustment_ids_get_reservation(stack_id, start_time, end_time, optional_adjustment_ids, memo)
    method = "makeReservationWithOptionalAdjustmentIdsGetReservation&stackId=" + stack_id + "&startTime=" + start_time + "&endTime=" + end_time + "&optionalAdjustmentIds=" + optional_adjustment_ids + "&memo=" + memo
    post_request(method)
  end

  def current_reservation
    method = "currentReservation"
    post_request(method)
  end

  def future_reservations
    method = "futureReservations"
    post_request(method)
  end

  def past_reservations
    method = "pastReservations"
    post_request(method)
  end

  def check_reservation_date_time(stamp)
    method = "checkReservationDateTime&stamp=" + stamp
    post_request(method)
  end

  def reservation_with_id(reservation_id)
    method = "reservationWithId&reservationId=" + reservation_id
    post_method(method)
  end

  def extend_reservation_with_id(reservation_id, end_time)
    method = "extendReservationWithId&reservationId=" + reservation_id + "&endTime=" + end_time
    post_request(method)
  end

  def extend_reservation_with_id_get_reservation(reservation_id, end_time)
    method = "extendReservationWithIdGetReservation&=" + reservation_id + "&endTime=" + end_time
    post_request(method)
  end

  def early_return_for_reservation_with_id(reservation_id, end_time)
    method = "earlyReturnForReservationWithId&reservationId=" + reseveration_id + "&endTime=" + end_time
    post_request(method)
  end

  def early_return_for_reservation_with_id_get_reservation(reservation_id, end_time)
    method = "earlyReturnForReservationWithIdGetReservation&=" + reservation_id + "&endTime=" + end_time
    post_request(method)
  end

  def early_arive_for_reservation_with_id(reservation_id, start_time)
    method = "earlyAriveForReservationWithId&=" + reservation_id + "&startTime=" + start_time
  end

  def early_arive_for_reservation_with_id_get_reservation(reservation_id, start_time)
    method = "earlyAriveForReservationWithIdGetReservation&reservationId=" + reservation_id + "&startTime=" + start_time
    post_request(method)
  end

  def edit_reservation_times(reservation_id, start_time, end_time)
    method = "editReservationTimes&reservationId=" + reservation_id + "&startTime=" + start_time + "&endTime=" + end_time
    post_request(method)
  end

  def edit_reservation_times_get_reservation(reservation_id, start_time, end_time)
    method = "editReservationTimesGetReservation&reservationId=" + reservation_id + "&startTime=" + start_time + "&endTime=" + end_time
    post_request(method)
  end

  def all_vehicle_types
    method = "allVehicleTypes"
    post_request(method)
  end

  def client_phone
    method = "clientPhone"
    post_request(method)
  end

  def amenities
    method = "amenities"
    post_request(method)
  end

  def results_from_stack_filter(a_stack_filter, include_stack)
    method = "resultsFromStackFilter&aStackFilter=" + a_stack_filter + "&includeStack=" + include_stack
  end

  def get_time_zone
    method = "getTimeZone"
    post_request(method)
  end

  def stack_for_id(stack_id, time)
    method = "stackForId&stackId=" + stack_id + "&time=" + time
    post_request(method)
  end

  def get_locale
    method = "getLocale"
    post_request(method)
  end

  def get_driver_locations
    method = "getDriverLocations"
    post_request(method)
  end

  def get_driver_name
    method = "getDriverName"
    post_request(method)
  end

  def cancel_reservation_with_id(reservation_id)
    method = "cancelReservationWithId&reservationId=" + reservation_id
    post_request(method)
  end

  def cancel_reservation_with_id_get_reservation(reservation_id)
    method = "cancelReservationWithIdGetReservation&reservationId=" + reservation_id
    post_request(method)
  end

  def get_configuration
    method = "getConfiguration"
    post_request(method)
  end

  def get_drivers_interesting_things
    method = "getDriversInterestingThings"
    post_request(method)
  end

  def get_current_and_future_reservations
    method = "getCurrentAndFutureReservations"
    post_request(method)
  end

  def get_driver_messages
    method = "getDriverMessages"
    post_request(method)
  end

  def get_current_and_future_reservations_and_driver_messages
    method = "getCurrentAndFutureReservationsAndDriverMessages"
    post_request(method)
  end

  def get_reservation_messages(reservation_id)
    method = "getReservationMessages&reservationId=" + reservation_id
    post_request(method)
  end

  def get_stack_messages(stack_id, start_time)
    method = "getStackMessages&stackId=" + stack_id + "&startTime=" + start_time
    post_request(method)
  end

  def has_linked_driver
    method = "hasLinkedDriver"
    post_request(method)
  end

  def get_other_driver_account_type
    method = "getOtherDriverAccountType"
    post_request(method)
  end

  def all_member_problem_types
    method = "allMemberProblemTypes"
    post_request(method)
  end

  def submit_problem(problem_type, reservation_id, message)
    method = "submitProblem&problemType=" + problem_type + "&reservationId=" + reservation_id + "&message=" + message
    post_request(method)
  end

  def start_trip_by_id(trip_id)
    method = "startTripById&tripId=" + trip_id
    post_request(method)
  end

  def end_trip_by_id(trip_id, end_odo)
    method = "endTripById&tripId=" + trip_id + "&endOdo=" + end_odo
    post_request(end_odo)
  end

  def vehicle_by_id(vehicle_id)
    method = "vehicleById&vehicleId=" + vehicle_id.to_s
    post_request(method)
  end

  def get_driver_language_locale
    method = "getDriverLanguageLocale"
    post_request(method)
  end

  def mark_read_once_message_as_read(message_id)
    method = "markReadOnceMessageAsRead&messageId=" + message_id
    post_request(method)
  end

  def is_logged_in_get_configuration
    method = "isLoggedInGetConfiguration"
    post_request(method)
  end

  def get_class
    method = "getClass"
    post_request(method)
  end

  def post_request(method)
    time =  Time.now.to_i.to_s
    hash_method = method.split('&').first

    username = cookies.signed[:username].to_s
    password = cookies.signed[:pwd]
    hash = Digest::SHA1.hexdigest(password + time + hash_method)
    uri = URI.parse("https://72.51.63.28/webservices/index.php/WSUser/WSRest?action=" + method + "&user=" + username + "&hash=" + hash + "&time=" + time + "&billcode=mobile")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Post.new(uri.request_uri)

    response = http.request(request)
    response.body
  end
end