require 'spec_helper'

describe "Profile Page Content" do
	subject { page }

	#Checks the content of the page is correct
	describe "Check content" do
	before { visit root_path }

	#Login to the page first
	describe "Login" do
	  before do
	    fill_in "session_username", with: "970"
	    fill_in "session_password", with: "usyd"
	    click_button "Login"
	  end

	  #Enter Profile Page
	  describe " click profile link" do
        before do
	      click_link "Profile"
	    end

	    #All the headings for the content
		it { current_path.should eq(profile_path) }
	  	it { should have_content ("Profile page")}
		it { should have_content ("Basic Information")}
		it { should have_content ("Time Zone:")}
		it { should have_content ("Name:")}
		it { should have_content ("Trip Time Resolution:")}
		it { should have_content ("Language Locale:")}
		it { should have_content ("Driver Location")}
		it { should have_content ("Description:")}
		it { should have_content ("Latitude:")}
		it { should have_content ("Longitude:")}
		it { should have_content ("Default:")}
		
		#Not sure whether to do extra variables here
		#Or check that in the controller spec for users.
		if @driversInterestingThings != nil
		end

		#Ensures the footer links are correct!
		describe "footer links" do
			describe " click home link" do
			before do
			  click_link "Home"
			end
			it { current_path.should eq(reservation_path) }
			#it { should have_content("Current Reservation") }
			#it { should have_content("Future Reservations") }
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

		#Ensures the header links are correct
		describe "header links" do
			describe "click contact us link" do
			before do
				click_link "Contact Us"
			end
			it { current_path.should eq(contact_path)}
			end
		#Need to add sign out
		end
	  end

	  end
  end
 
end