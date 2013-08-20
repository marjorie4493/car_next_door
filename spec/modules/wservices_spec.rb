require 'spec_helper'

class Dummy
  include Wservices
end

it "get amenities" do
  @dummy = Dummy.new
end