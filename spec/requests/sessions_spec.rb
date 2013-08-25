require 'spec_helper'

describe "Sessions" do
  subject { page }
  
  describe "Login page" do
    before { visit root_path }
    it { should have_content("Login") }
    it { should_not have_link("Home") }
	it { should_not have_link("Reserve") }
	it { should_not have_link("Manage") }
	it { should_not have_link("Profile") }
	it { should_not have_link("Sign out") }
  end
end
