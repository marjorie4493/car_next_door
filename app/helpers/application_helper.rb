module ApplicationHelper
  def logged_in?
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

    uri = URI.parse("https://reserve.carnextdoor.com.au/webservices/index.php/WSUser/WSRest?action=" + method + "&user=" + username + "&hash=" + hash + "&time=" + time + "&billcode=mobile")
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

  def link_to_submit(text)
    link_to_function text, "$(this).closest('form').submit()"
  end
end

#72.51.63.28