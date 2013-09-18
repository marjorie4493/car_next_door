class ApplicationController < ActionController::Base
  require 'net/https'
  require 'uri'
  #require 'wservices'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Validates credentials to allow access to restricted pages
  def is_logged_in?
  	username = cookies.signed[:username]
  	password = cookies.signed[:pwd]
  	
  	if username.nil? || password.nil?
  		false
  	elsif password.empty? || username.empty? 
  		false
  	else
      true
  	end
  end
  
  # Post request to ensure the user credentials are correct
  def valid_login(username, password)
	  time =  Time.now.to_i.to_s
	  method = "isLoggedIn"
	  hash = Digest::SHA1.hexdigest(password + time + method)

	  uri = URI.parse("https://72.51.63.28/webservices/index.php/WSUser/WSRest?action=" + method + "&user=" + username + "&hash=" + hash + "&time=" + time + "&billcode=mobile")
	  http = Net::HTTP.new(uri.host, uri.port)
	  http.use_ssl = true
	  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	  request = Net::HTTP::Post.new(uri.request_uri)

	  response = http.request(request)
	  res = Nokogiri::XML(response.body)
	  root = res.root

	  if root.xpath("/methodResponse").text  == "1"
	  	true
	  else
	  	false
	  end
	end

	# Creates signed user cookies
	def create_cookies(username, password)
		cookies.signed[:username] = { 
	 		value: username,
	 		expires: 2.weeks.from_now }
	 	cookies.signed[:pwd] = {
	 		value: password,
	 		expires: 2.weeks.from_now }
	end

  # Destroy cookies
	def sign_out
		cookies.delete(:username)
		cookies.delete(:pwd)
	end

	def time_to_next_quarter_hour(time)
      array = time.split(':')
      minutes = array[1].split(' ')
      quarter = ((minutes[0].to_i % 60) / 15.0).ceil
      if quarter < 4
        mins = (quarter * 15) % 60
      elsif quarter == 4
        mins = "00"
        unless array[0] == 12
          array[0] = array[0].to_i + 1
        else
          array[0] = 1
        end
      end
      time = array[0].to_s.rjust(2, '0') + ":" + mins.to_s.rjust(2, '0') + " " + minutes[1].to_s
    end
end
