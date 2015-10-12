require 'rails_helper'

describe "GET /api/posts" do

def get_request params
  auth_get '/api/posts', params
end

let!(:test_category) {
  PostCategory.create(name: "test post category")
}

let!(:post) {
  Post.create(title: "test title", excerpt: "test excerpt", content: "test content", status: 1, posted_date: "2015-10-08", post_category_id: test_category.id, user_id: current_user.id, last_updated_by: current_user.id)
}
    
describe "post index with pagination" do


  it "should get all posts in page 1" do
    get_request({page: 1})
    expect(json_response).to include('collection')
    expect(json_response).to include('metadata')
    collection = json_response['collection']
    metadata = json_response['metadata']
    expect(collection.count).to_not be < 1
    collection.each do |c|
      expect(c).to include('title')
      expect(c).to include('slug')
      expect(c).to include('posted_date')
      expect(c).to include('excerpt')
      expect(c).to include('content')
      expect(c).to include('featured')
      expect(c).to include('creator_name')
      expect(c).to include('updator_name')
    end
    expect(metadata).to include("count")
    expect(metadata).to include("current_page")
  end

  it "should get all posts in page 2" do
    get_request({page: 2})
    expect(json_response).to include('collection')
    collection = json_response['collection']
    expect(collection.count).to eql(0)
  end
end

  
end