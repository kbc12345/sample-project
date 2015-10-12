require 'rails_helper'

describe "PATCH /api/posts" do

  def patch_request params
    auth_patch "/api/posts/#{test_post.id}", post: params
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

  let(:updated_params) do
    {
      title: "updated title",
      content: "updated content"
    }
  end

  let!(:test_category) {
    PostCategory.create(name: "test post category")
  }
      
  describe "update post scenarios" do
    it "should return json with success" do
      patch_request(updated_params)
      expect(json_response).to include('success')
    end

    it "should successfully update the title of test_post" do
      patch_request(updated_params)
      test_post.reload.title
      expect(test_post.title).to eq("updated title")
    end

    it "should successfully update the content of test_post" do
      patch_request(updated_params)
      test_post.reload.content
      expect(test_post.content).to eq("updated content")
    end

    # it "should successfully update the last_updated_by of test_post" do
    #   patch_request(update_params)
    #   test_post.reload.last_updated_by
    #   expect(test_post.last_updated_by).to eq(current_user.id)
    # end
  end

  describe "update post with missing required params" do
    it "should return json with validation failed" do
      patch_request({title: ""})
      expect(json_response).to include("message")
      message = json_response["message"]
      expect(message).to eq("Validation failed")
    end
  end

  
end