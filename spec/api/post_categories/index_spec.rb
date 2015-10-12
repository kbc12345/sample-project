require 'rails_helper'

describe "GET /api/post_categories" do

def get_request
  auth_get '/api/post_categories', nil
end

let!(:post_category){
  PostCategory.create(name: "test category")
}   

describe "post categories index" do
  it "should get all post categories" do
    get_request
    expect(json_response).to include('collection')
    collection = json_response['collection']
    expect(collection.count).to_not be < 1
    collection.each do |c|
      expect(c).to include('name')
    end
  end
end

  
end