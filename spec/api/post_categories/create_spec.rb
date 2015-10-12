require 'rails_helper'

describe "POST /api/post_categories" do

  let(:correct_params) do
    {
      name: "test_name"
    }
  end

  let(:invalid_params) do
    {
      name: ""
    }
  end

  def post_request params
    auth_post '/api/post_categories/', post_category: params
  end
    
  describe "create post_category successfully" do
    it "should return json with id of created post_category" do
      post_request(correct_params)
      expect(json_response).to include('id')
      expect(json_response.count).to eql(1)
    end
  end

  describe "create post_category with invalid name" do
    it "should return json with validation failed message and an error message" do
      post_request(invalid_params)
      expect(json_response).to include('message')
      message = json_response['message']
      errors = json_response['errors']
      expect(message).to eq("Validation failed")
      expect(errors).to include("Name can't be blank")
    end
  end

end