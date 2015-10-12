require 'rails_helper'

describe "PATCH /api/messages" do

  def delete_request
    auth_delete "/api/messages/#{test_message.id}", nil
  end

  let(:test_message) {
    Message.create(
      sender: "test sender",
      email: "test@test.com",
      message: "test message"
      )
  }
      
  describe "delete test_message" do
    it "should return json with success" do
      delete_request
      expect(json_response).to include('success')
    end

    it "should return count equal 0" do
      delete_request
      expect(Message.count).to eq(0)
    end
  end
  
end