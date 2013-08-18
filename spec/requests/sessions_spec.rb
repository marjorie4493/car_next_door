require 'spec_helper'

describe "Sessions" do
  subject { page }
  
  describe "Login page" do
    before { visit root_path }
    it { should have_content("Login") }
  end

  describe "Login" do
    before { visit root_path }
    describe "with valid login credentials" do
      before do
        fill_in "session_username", with: "971"
        fill_in "session_password", with: "usyd"
        click_button "Login"
      end
      it { should have_content("You have signed in") }
    end

    describe "with invalid login credentials" do
      before do
        fill_in "session_username", with: "example"
        fill_in "session_password", with: "password"
        click_button "Login"
      end
      it { should have_content("Login") }
      it { should_not have_content("You have signed in") }
    end
  end
end
