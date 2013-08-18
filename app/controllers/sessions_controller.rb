class SessionsController < ApplicationController
	require 'net/https'
	require 'uri'  
	include Wservices
	def create
		if valid_login(params[:session][:username], Digest::SHA1.hexdigest(params[:session][:password]))
      password_hash = Digest::SHA1.hexdigest(params[:session][:password])
			create_cookies(params[:session][:username], Digest::SHA1.hexdigest(params[:session][:password]))
	 		redirect_to reservation_path
	 	else
      flash[:error] = "Invalid username/password"  
	 		redirect_to root_path
	 	end
	end
  
  def destroy
  	sign_out
  	redirect_to root_path
  end

  def new
  	if is_logged_in?
  		redirect_to reservation_path
  	end
  end
end
