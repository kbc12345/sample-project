require 'rails_helper'

describe "PATCH /api/users" do
  
  let(:temp_user){
    User.create(first_name: "temp_firstname", last_name: "temp_lastname", email: "temp_email@test.com", password: "temp_password")
  }

  let(:update_params) do
    {
      email: "updated_email@test.com",
      first_name: "updated_firstname",
      last_name: "updated_lastname"
    }
  end

  def patch_request params
    auth_patch "/api/users/#{temp_user.id}", {user: params}
  end

  describe "update success scenarios" do
    it "should return json with success attribute" do
      patch_request(update_params)
      expect(json_response).to include('success')
    end

    it "should successfully update the email of temp user" do
      patch_request(update_params)
      temp_user.reload.email
      expect(temp_user.email).to eq("updated_email@test.com")
    end

    it "should successfully update the first_name of temp user" do
      patch_request(update_params)
      temp_user.reload.first_name
      expect(temp_user.first_name).to eq("updated_firstname")
    end
  end

  describe "update fail scenarios" do
    it "should return json with validation failed message" do
      patch_request({email: "test@test.com"})
      expect(json_response).to include('message')
      message = json_response['message']
      expect(message).to eq("Validation failed")
    end
  end

end