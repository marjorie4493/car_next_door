class Vehicle
  include ActiveModel::Model 
  include Post

  def initialize(user_details)
    @username = user_details[:username].to_s
    @password = user_details[:password].to_s
  end

  # Gets the clients timezone
  def get_time_zone
    method = "getTimeZone"
    post_request(method)
  end

  # Get class.
  def get_class
    method = "getClass"
    post_request(method)
  end

  # Returns an array of messages for the specified stack. These 
  # messages include stack, vehicle and lot messages.
  def get_stack_messages(stack_id, start_time)
    method = "getStackMessages&stackId=" + stack_id.to_s + "&startTime=" + start_time.to_s
    post_request(method)
  end

   # Returns a vehicle from the vehicle id.
  def vehicle_by_id(vehicle_id)
    method = "vehicleById&vehicleId=" + vehicle_id.to_s
    hash = post_request(method)
    result = {}
  
    vehicle = {}
      vehicle[:year] = hash["DBEntityVehicle"][0]["year"][0]
      vehicle[:colour] = hash["DBEntityVehicle"][0]["colour"][0]
      vehicle[:plate] = hash["DBEntityVehicle"][0]["plate"][0]
      vehicle[:make] = hash["DBEntityVehicle"][0]["make"][0]
      vehicle[:model] = hash["DBEntityVehicle"][0]["model"][0]
      vehicle[:remark] = hash["DBEntityVehicle"][0]["remark"][0]
    result[:info] = vehicle
    
    amenities = hash["DBEntityVehicle"][0]["features"][0]["WSAmenity"]
      amenities_array = []
      amenities.each { |x| 
      amenities_array.push( { :name  => x["name"],
                                :description => x["description"][0] })
      }
      result[:amenities] = amenities_array
    result
  end

   def all_vehicle_types
    method = "allVehicleTypes"
    hash = post_request(method)

    # breaks down big hash of cars into hashes 
    vehicles = hash["DBEntityVehicleType"]
    vehicle_array = []

    if !hash["DBEntityVehicleType"][0].nil?
      vehicles.each { |x| 
        vehicle_array.push( { :descr     => x["descr"][0],
                              :longDescr => x["longDescr"][0],
                              :id        => x["id"][0],
                              :thumbDest => x["thumbDest"][0],
                              :imageDest => x["imageDest"][0],
                              :usage     => x["usage"][0] } ) 
      }
    end
    vehicle_array
  end

  def amenities
    method = "amenities"
    hash = post_request(method)
    amenities = hash["WSAmenity"]
    amenities_array = []

    if !amenities.nil?
      amenities.each { |x| 
        amenities_array.push( { :name        => x["name"][0],
                                :description => x["description"][0] } ) 
      }
    end
    amenities_array
  end
end
