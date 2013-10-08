class User
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

 # returns a set of interesting things about this driver.
  def get_drivers_interesting_things
    method = "getDriversIntrestingThings"
    hash = post_request(method)
    drivers_things = {}
  
    #breaks down things for the drivers configuration results
    if !hash["WSDriversIntrestingThings"][0]["WSGetConfigurationResult"].nil?
      drivers_things_config_result = hash["WSDriversIntrestingThings"][0]["WSGetConfigurationResult"][0]

      drivers_things[:time_zone] = drivers_things_config_result["timeZone"][0]
      drivers_things[:trip_time_resolution] = drivers_things_config_result["tripTimeResolution"][0]
      drivers_things[:driver_name] = drivers_things_config_result["driverName"][0]
      drivers_things[:other_account_type] = drivers_things_config_result["otherAccountType"][0]
      drivers_things[:max_reservation_memo_length] = drivers_things_config_result["maxReservationMemoLength"][0]
      drivers_things[:extra_field_is_job_code] = drivers_things_config_result["extraFieldIsJobCode"][0]
      drivers_things[:driver_language_locale] = drivers_things_config_result["driverLanguageLocale"][0]
      end

    if !hash["WSDriversIntrestingThings"][0]["WSGetCurrentAndFutureReservationsResult"][0]["futureReservations"][0]["DBEntityReservation"][0]["DBEntityDriver"][0].nil?
      drivers_things_driver_details = hash["WSDriversIntrestingThings"][0]["WSGetCurrentAndFutureReservationsResult"][0]["futureReservations"][0]["DBEntityReservation"][0]["DBEntityDriver"][0]
      
      drivers_things[:full_name] = drivers_things_driver_details["fullName"][0]
      drivers_things[:is_main_driver] = drivers_things_driver_details["isMainDriver"][0]
      drivers_things[:driver_status] = drivers_things_driver_details["status"][0]
      drivers_things[:key_fob_ID] = drivers_things_driver_details["keyfobID"][0]
      drivers_things[:login_name] = drivers_things_driver_details["loginName"][0]

    elsif !hash["WSDriversIntrestingThings"][0]["WSGetCurrentAndFutureReservationsResult"][0]["currentReservations"][0]["DBEntityReservation"][0]["DBEntityDriver"][0].nil?
      drivers_things_driver_details = hash["WSDriversIntrestingThings"][0]["WSGetCurrentAndFutureReservationsResult"][0]["currentReservations"][0]["DBEntityReservation"][0]["DBEntityDriver"][0]
      
      drivers_things[:full_name] = drivers_things_driver_details["fullName"][0]
      drivers_things[:is_main_driver] = drivers_things_driver_details["isMainDriver"][0]
      drivers_things[:driver_status] = drivers_things_driver_details["status"][0]
      drivers_things[:key_fob_ID] = drivers_things_driver_details["keyfobID"][0]
      drivers_things[:login_name] = drivers_things_driver_details["loginName"][0]

      end

    if !hash["WSDriversIntrestingThings"][0]["WSGetCurrentAndFutureReservationsResult"][0]["futureReservations"][0]["DBEntityReservation"][0]["DBEntityDriver"][0]["DBEntityMember"][0].nil?
      drivers_things_member_details = hash["WSDriversIntrestingThings"][0]["WSGetCurrentAndFutureReservationsResult"][0]["futureReservations"][0]["DBEntityReservation"][0]["DBEntityDriver"][0]["DBEntityMember"][0]
      
      drivers_things[:member_type] = drivers_things_member_details["type"][0]
      drivers_things[:main_name] = drivers_things_member_details["mainName"][0]
      drivers_things[:start_date] = drivers_things_member_details["startDate"][0]
      drivers_things[:member_status] = drivers_things_member_details["status"][0]
      drivers_things[:billing_exempt] = drivers_things_member_details["billingExempt"][0]
      drivers_things[:quit_date] = drivers_things_member_details["quitDate"][0]
      drivers_things[:close_date] = drivers_things_member_details["closeDate"][0]
      drivers_things[:is_valet] = drivers_things_member_details["isValet"][0]
      drivers_things[:member_id] = drivers_things_member_details["id"][0]
      drivers_things[:entity_type] = drivers_things_member_details["entityType"][0]
      
    elsif !hash["WSDriversIntrestingThings"][0]["WSGetCurrentAndFutureReservationsResult"][0]["currentReservations"][0]["DBEntityReservation"][0]["DBEntityDriver"][0]["DBEntityMember"][0].nil?
      drivers_things_member_details = hash["WSDriversIntrestingThings"][0]["WSGetCurrentAndFutureReservationsResult"][0]["futureReservations"][0]["DBEntityReservation"][0]["DBEntityDriver"][0]["DBEntityMember"][0]
      
      drivers_things[:member_type] = drivers_things_member_details["type"][0]
      drivers_things[:main_name] = drivers_things_member_details["mainName"][0]
      drivers_things[:start_date] = drivers_things_member_details["startDate"][0]
      drivers_things[:member_status] = drivers_things_member_details["status"][0]
      drivers_things[:billing_exempt] = drivers_things_member_details["billingExempt"][0]
      drivers_things[:quit_date] = drivers_things_member_details["quitDate"][0]
      drivers_things[:close_date] = drivers_things_member_details["closeDate"][0]
      drivers_things[:is_valet] = drivers_things_member_details["isValet"][0]
      drivers_things[:member_id] = drivers_things_member_details["id"][0]
      drivers_things[:entity_type] = drivers_things_member_details["enitityType"][0]

      end

    #Member Type Details
    if !hash["WSDriversIntrestingThings"][0]["WSGetCurrentAndFutureReservationsResult"][0]["futureReservations"][0]["DBEntityReservation"][0]["DBEntityDriver"][0]["DBEntityMember"][0]["DBEntityMemberType"][0].nil?
      drivers_things_member_type_details = hash["WSDriversIntrestingThings"][0]["WSGetCurrentAndFutureReservationsResult"][0]["futureReservations"][0]["DBEntityReservation"][0]["DBEntityDriver"][0]["DBEntityMember"][0]["DBEntityMemberType"][0]
      
      drivers_things[:member_type_name]   = drivers_things_member_type_details["name"][0]
      drivers_things[:member_type_descr]  = drivers_things_member_type_details["descr"][0]
      drivers_things[:is_Residential]     = drivers_things_member_type_details["isResidential"][0]
      drivers_things[:member_type_ID]     = drivers_things_member_type_details["id"][0]
      drivers_things[:member_entity_type] = drivers_things_member_type_details["entityType"][0]
    
    elsif !hash["WSDriversIntrestingThings"][0]["WSGetCurrentAndFutureReservationsResult"][0]["currentReservations"][0]["DBEntityReservation"][0]["DBEntityDriver"][0]["DBEntityMember"][0]["DBEntityMemberType"][0].nil?
      drivers_things_member_type_details = hash["WSDriversIntrestingThings"][0]["WSGetCurrentAndFutureReservationsResult"][0]["futureReservations"][0]["DBEntityReservation"][0]["DBEntityDriver"][0]["DBEntityMember"][0]["DBEntityMemberType"][0]
      
      drivers_things[:member_type_name]   = drivers_things_member_type_details["name"][0]
      drivers_things[:member_type_descr]  = drivers_things_member_type_details["descr"][0]
      drivers_things[:is_Residential]     = drivers_things_member_type_details["isResidential"][0]
      drivers_things[:member_type_ID]     = drivers_things_member_type_details["id"][0]
      drivers_things[:member_entity_type] = drivers_things_member_type_details["entityType"][0]
      
      end

    #Driver Location Details
    if !hash["WSDriversIntrestingThings"][0]["driverLocations"][0]["DBDriverLocation"][0].nil?
      drivers_things_driver_locations = hash["WSDriversIntrestingThings"][0]["driverLocations"][0]["DBDriverLocation"][0]

      drivers_things[:description] = drivers_things_driver_locations["description"][0]
      drivers_things[:latitude]    = drivers_things_driver_locations["latitude"][0]
      drivers_things[:longitude]   = drivers_things_driver_locations["longitude"][0]
      drivers_things[:default]     = drivers_things_driver_locations["default"][0]
      end
    drivers_things 
  end

      # Returns user configuration.
  def get_configuration
    method = "getConfiguration"
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

   # Returns array containing locale information for the client.
  def get_locale
    method = "getLocale"
    post_request(method)
  end

  # Returns an array of driver locations.
  def get_driver_locations
    method = "getDriverLocations"
    hash = post_request(method)
    location = {}
    if !hash["DBDriverLocation"].nil?
      location[:description]  = hash["DBDriverLocation"][0]["description"][0]
      location[:latitude]     = hash["DBDriverLocation"][0]["latitude"][0]
      location[:longitude]    = hash["DBDriverLocation"][0]["longitude"][0]
      location[:default]      = hash["DBDriverLocation"][0]["default"][0]
    end
    location
  end
  #{"DBDriverLocation"=>[{"description"=>["Home"], "latitude"=>["-33.889914"], "longitude"=>["151.190560"], "default"=>["1"]}]}
  # Return the driver's name.
  def get_driver_name
    method = "getDriverName"
    post_request(method)
  end

   # Returns an array of messages for the logged in driver.
  def get_driver_messages
    method = "getDriverMessages"
    hash = post_request(method)
=begin
    message_list = hash["DBEntityMessage"][0]
    messages = []
    if !message_list.nil?
      message_list.each { |x|
        messages.push( {  :descr             => x["descr"][0],
                          :text              => x["text"][0],
                          :mobileText        => x["mobileText"][0],
                          :linkText          => x["linkText"][0],
                          :afterAckLinkText  => x["afterAckLinkText"][0],
                          :requireCheckBox   => x["requireCheckBox"][0],
                          :priorityPk        => x["priorityPk"][0],
                          :priority          => x["priority"][0],
                          :priorityPKtoValue => x["priorityPKtoValue"][0],
                          :id                => x["id"][0],
                          :type              => x["type"][0]

                          } ) }
    end
    messages
=end
  end
  
  # Get locale of driver.
  def get_driver_language_locale
    method = "getDriverLanguageLocale"
    post_request(method)
  end

end