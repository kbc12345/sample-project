require 'rails_helper'

describe "test models/user methods" do

  let(:test_user){
      User.create(first_name: "ken", last_name: "chung", email: "kenchung@test.com", password: "password")
    }
      
  describe "test full name of user" do


    it "should return the full name of user" do
      full_name = test_user.full_name
      expect(full_name).to eq(test_user.first_name + " " + test_user.last_name)
    end
  end

  # describe "test destroy access token" do
  #   it "should set nil as the user's access token" do
  #     test_user.set_access_token
  #     test_user.destroy_access_token
  #     expect(test_user.access_token). to be(nil)
  #   end
  # end

  
end