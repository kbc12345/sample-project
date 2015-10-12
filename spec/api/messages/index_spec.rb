require 'rails_helper'

describe "GET /api/messages" do

def get_request params
  auth_get '/api/messages', params
end

let!(:message) {
  Message.create(sender: "kenchung", email: "test@test.com", message: "test message")
}
    
describe "message index with pagination" do


  it "should get all messages in page 1" do
    get_request({page: 1})
    expect(json_response).to include('collection')
    expect(json_response).to include('metadata')
    collection = json_response['collection']
    metadata = json_response['metadata']
    expect(collection.count).to_not be < 1
    collection.each do |c|
      expect(c).to include('sender')
      expect(c).to include('email')
      expect(c).to include('message')
    end
    expect(metadata).to include("count")
    expect(metadata).to include("current_page")
  end

  it "should get all messages in page 2" do
    get_request({page: 2})
    expect(json_response).to include('collection')
    collection = json_response['collection']
    expect(collection.count).to eql(0)
  end
end

  
end