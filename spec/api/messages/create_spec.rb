require 'rails_helper'

describe "POST /api/messages" do

  def post_request params
    auth_post '/api/messages', message: params
  end

  let(:valid_params) do
    {
      sender: "test sender", 
      email: "test@test.com", 
      message: "test message"
    }
  end
      
  describe "create message successfully" do
    it "should return json with id" do
      post_request(valid_params)
      expect(json_response).to include("id")
      expect(json_response.count).to eql(1)
    end
  end

  describe "create message with missing required params" do
    it "should return json with validation failed" do
      post_request({sender: "", email: "", message: ""})
      expect(json_response).to include("message")
      message = json_response["message"]
      expect(message).to eq("Validation failed")
    end
  end

  
end