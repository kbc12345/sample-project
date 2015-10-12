require 'rails_helper'

describe "DELETE /api/users" do

  let(:temp_user){
    User.create(first_name: "temp_firstname", last_name: "temp_lastname", email: "temp_email@test.com", password: "temp_password")
  }

  def delete_request
    auth_delete "/api/users/#{temp_user.id}", nil
  end
    
  describe "delete user successfully" do
    it "should return json with success" do
      delete_request
      expect(json_response).to include('success')
    end

    it "should return count equal to 1" do
      delete_request
      expect(User.count).to eq(1)
    end
  end

end