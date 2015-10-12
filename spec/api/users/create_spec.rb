require 'rails_helper'

describe "POST /api/users" do

  let(:correct_params) do
    {
      first_name: "test_firstname",
      last_name: "test_lastname",
      email: "test_email@test.com",
      password: "test_password"
    }
  end

  let(:invalid_params) do
    {
      first_name: "test_firstname",
      last_name: "test_lastname",
    }
  end

  def post_request params
    auth_post '/api/users/', user: params
  end
    
  describe "create user successfully" do
    it "should return json with id of created user" do
      post_request(correct_params)
      expect(json_response).to include('id')
      expect(json_response.count).to eql(1)
    end
  end

  describe "create user with existing email" do
    it "should return json with validation failed message and an error message" do
      post_request(invalid_params.merge({email: "test@test.com", password: "password"}))
      expect(json_response).to include('message')
      message = json_response['message']
      errors = json_response['errors']
      expect(message).to eq("Validation failed")
      expect(errors).to include("Email has already been taken")
    end
  end

  describe "create user with an invalid password" do
    it "should return json a Password can't be blank error message" do
      post_request(invalid_params.merge({email: "test_email@test.com", password: ""}))
      expect(json_response).to include('message')
      message = json_response['message']
      errors = json_response['errors']
      expect(message).to eq("Validation failed")
      expect(errors).to include("Password can't be blank")
    end

    it "should return json a Password must be at least 8 characters error message" do
      post_request(invalid_params.merge({email: "test_email@test.com", password: "abc"}))
      expect(json_response).to include('message')
      message = json_response['message']
      errors = json_response['errors']
      expect(message).to eq("Validation failed")
      expect(errors).to include("Password must be at least 8 characters")
    end

  end

end