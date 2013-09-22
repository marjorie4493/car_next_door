require "spec_helper"
# This file checks all the routing is correct!
# Reference to routes.rb, where all the routes are! 
  describe "routing" do

    it "routes to #index" do
      get("/reservation").should route_to("reservations#index")
    end

    it "routes to #edit" do
      get("/reservation/edit").should route_to("reservations#edit")
    end

    it "routes to #view" do
      get("/reservation/view").should route_to("reservations#view")
    end

    it "routes to #profile" do
      get("/profile").should route_to("users#profile")
    end

    it "routes to #new" do
      get("/new").should route_to("reservations#new")
    end

    it "routes to #contact" do
      get("/contact").should route_to("static_pages#contact")
    end

    it "routes to #destroy" do
      delete("/signout").should route_to("sessions#destroy")
    end

    it "routes to #extend" do
      get("/reservation/extend").should route_to("reservations#extend")
    end

    it "routes to #early" do
      get("/reservation/early").should route_to("reservations#early")
    end

  end
