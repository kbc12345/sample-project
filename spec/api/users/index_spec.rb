require 'rails_helper'

describe "GET /api/users" do

 def get_request params
  auth_get '/api/users', params
 end
    
  describe "user index with pagination" do


    it "should get all users in page 1" do
      get_request({page: 1})
      expect(json_response).to include('collection')
      collection = json_response['collection']
      expect(collection.count).to_not be < 1
      collection.each do |c|
        expect(c).to include('first_name')
        expect(c).to include('last_name')
        expect(c).to include('email')
        expect(c).to include('access_token')
        expect(c).to_not include('encrypted_password')
      end
    end

    it "should get all users in page 2" do
      get_request({page: 2})
      expect(json_response).to include('collection')
      collection = json_response['collection']
      expect(collection.count).to eql(0)
    end
  end

  
end