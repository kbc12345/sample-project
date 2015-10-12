require 'rails_helper'

describe "PATCH /api/posts" do

  def delete_request
    auth_delete "/api/posts/#{test_post.id}", nil
  end

  let(:test_post) {
    Post.create(
      title: "test title", 
      excerpt: "test excerpt", 
      content: "test content", 
      status: 1, 
      posted_date: "2015-10-08", 
      post_category_id: test_category.id
      )
  }

  let!(:test_category) {
    PostCategory.create(name: "test post category")
  }
      
  describe "delete test_post" do
    it "should return json with success" do
      delete_request
      expect(json_response).to include('success')
    end

    it "should return count equal 0" do
      delete_request
      expect(Post.count).to eq(0)
    end
  end
  
end