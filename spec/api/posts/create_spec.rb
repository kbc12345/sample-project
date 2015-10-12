require 'rails_helper'

describe "POST /api/posts" do

  def post_request params
    auth_post '/api/posts', post: params
  end

  let(:valid_params) do
    {
      title: "test title", 
      excerpt: "test excerpt", 
      content: "test content", 
      status: 1, 
      posted_date: "2015-10-08", 
      post_category_id: test_category.id
    }
  end

  let!(:test_category) {
    PostCategory.create(name: "test post category")
  }
      
  describe "create post successfully" do
    it "should return json with id" do
      post_request(valid_params)
      expect(json_response).to include("id")
      expect(json_response.count).to eql(1)
    end
  end

  describe "create post with missing required params" do
    it "should return json with validation failed" do
      post_request({title: "test title"})
      expect(json_response).to include("message")
      message = json_response["message"]
      expect(message).to eq("Validation failed")
    end
  end

  
end