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
  		valid_login(username, password)
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
end
