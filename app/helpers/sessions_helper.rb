module SessionsHelper

  def randomise
    random = []
  
    while random.length != 3 do
      number = rand(1..16)
  	  included = false
      random.each do |n|
        if n == number
	      included = true
	    end
	  end
      if included == false
        random << number
      end	  
    end  
	random
  end
  
end
