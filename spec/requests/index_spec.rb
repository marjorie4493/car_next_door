require 'spec_helper'

describe "Index Page Content" do
  subject { page }

  describe "Check content" do
    before { visit root_path }
    describe "for borrower" do
      before do
        fill_in "session_username", with: "971"
        fill_in "session_password", with: "usyd"
        click_button "Login"
      end
	  if @current.nil? #DOES NOT WORK ERROR 
	    it { should_not have_button("Current Reservation") }
	    it { should have_content("You have no current reservation.") }
	  else
		  it { should have_button("Current Reservation") }
		  it { should_not have_content("You have no current reservation.") }
	  end
	  if @future.nil? #DOES NOT WORK ERRORRR
	    it { should_not have_button("Future Reservations") }
	    it { should have_content("You have no future reservations.") }
	  else
		  it { should have_button("Future Reservations") }
		  it { should_not have_content("You have no future reservations.") }
	  end
  end
	
	describe "for owner" do
      before do
        fill_in "session_username", with: "970"
        fill_in "session_password", with: "usyd"
        click_button "Login"
      end
      if @current == nil
	    it { should_not have_button("Current Reservation") }
	    it { should have_content("You have no current reservation.") }
		else
		it { should have_button("Current Reservation") }
		it { should_not have_content("You have no current reservation.") }
	  end
	  if @future == nil
	    it { should_not have_button("Future Reservations") }
	    it { should have_content("You have no future reservations.") }
	  else
		it { should have_button("Future Reservations") }
		it { should_not have_content("You have no future reservations.") }
	  end
    end 
	
	describe "of contact page" do
    before { visit root_path }
    describe "when press link" do
      before do
	    fill_in "session_username", with: "970"
        fill_in "session_password", with: "usyd"
        click_button "Login"
	    click_link "Contact Us"
	  end
	  it { current_path.should eq(contact_path) }
  	  it { should have_content("Contact Us")}
    end	 
  end
	
  end
  
describe "Footer Links" do
  subject { page }

  describe "Login" do
    before { visit root_path }
    describe " with valid login credentials" do
      before do
        fill_in "session_username", with: "970"
        fill_in "session_password", with: "usyd"
        click_button "Login"
      end
	  describe " click home link" do
        before do
	      click_link "Home"
	    end
		it { current_path.should eq(reservation_path) }
	    #current reservations and 
	    #future reservations
	    #should have content of etc
	  end 
	  
	  describe " click reserve link" do
        before do
	      click_link "Reserve"
	    end
		it { current_path.should eq(new_path) }
	    it { should have_content("New Reservation") }
	  end 

	  describe " click profile link" do
        before do
	      click_link "Profile"
	    end
		it { current_path.should eq(profile_path) }
	    it { should have_content("Profile page") }
	  end
    end
  end
end
end