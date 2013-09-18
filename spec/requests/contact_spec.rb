require 'spec_helper'

describe "Contact Us Page Content" do
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
	  describe " click contact us link" do
        before do
	      click_link "Contact Us"
	    end

	    #All the headings for the content
		it { current_path.should eq(contact_path) }
	  	it { should have_content ("Contact Us")}
		it { should have_content ("Address")}
		it { should have_content ("Car Next Door")}
		it { should have_content ("Level 2")}
		it { should have_content ("608 Harris St")}
		it { should have_content ("Ultimo NSW 2007")}
		it { should have_content ("AUSTRALIA")}
		it { should have_content ("Phone Number")}
		it { should have_content ("(02) 8035 8000")}
		it { should have_content ("Fax")}
		it { should have_content ("Email Address")}
		it { should have_content ("info@carnextdoor.com")}
		it { should have_content ("Roadside Assistance")}
		it { should have_content ("1800 225 111")}
		it { should have_content ("For detailed support information, please visit the")}
		it { should have_content ("Support Centre")}

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
			# describe "click sign out link" do
			# before do
			# 	click_link "Sign Out"
			# end
			# it { current_path.should eq(signout_path)}
			# end
		#Need to add sign out???
		end
	  end

	  end
  end
 
end