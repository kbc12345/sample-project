require 'rails_helper'

describe "DELETE /api/post_categories" do

  let(:temp_post_category){
    PostCategory.create(name: "temp name")
  }

  def delete_request
    auth_delete "/api/post_categories/#{temp_post_category.id}", nil
  end
    
  describe "delete post_category successfully" do
    it "should return json with success" do
      delete_request
      expect(json_response).to include('success')
    end

    it "should return count equal to 0" do
      delete_request
      expect(PostCategory.count).to eq(0)
    end
  end

end