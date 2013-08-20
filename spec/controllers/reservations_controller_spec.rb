require 'spec_helper'

describe ReservationsController do
  it "GET index without login" do
    cookies.delete(:username) 
    cookies.delete(:password)
    get :index
    response.should be_redirect
  end
end
