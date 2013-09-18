require 'spec_helper'

describe "Authentications" do
  subject { page }

  describe "Login" do
    before { visit root_path }
    describe "with valid login credentials" do
      before do
        fill_in "session_username", with: "971"
        fill_in "session_password", with: "usyd"
        click_button "Login"
      end
      it { should have_link("Home") }
	    it { should have_link("Reserve") }
	    it { should have_link("Profile") }
	    it { should have_link("Sign out") }
    end

    describe "with invalid login credentials" do
      before do
        fill_in "session_username", with: "example"
        fill_in "session_password", with: "password"
        click_button "Login"
      end
      it { should have_button("Login") }
      it { should_not have_content("You have signed in") }
    end

    describe "with empty login credentials" do
      before do
        fill_in "session_username", with: ""
        fill_in "session_password", with: ""
        click_button "Login"
      end
      it { should have_button("Login") }
      it { should_not have_content("You have signed in") }
    end
  end
end
