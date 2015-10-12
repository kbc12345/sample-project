require 'rails_helper'

describe "PATCH /api/post_categories" do
  
  let(:temp_post_category){
    PostCategory.create(name: "temp name")
  }

  let(:update_params) do
    {
      name: "updated name"
    }
  end

  def patch_request params
    auth_patch "/api/post_categories/#{temp_post_category.id}", {post_category: params}
  end

  describe "update success scenarios" do
    it "should return json with success attribute" do
      patch_request(update_params)
      expect(json_response).to include('success')
    end

    it "should successfully update the name of temp_post_category" do
      patch_request(update_params)
      temp_post_category.reload.name
      expect(temp_post_category.name).to eq("updated name")
    end
  end

  describe "update fail scenarios" do
    it "should return json with validation failed message" do
      patch_request({name: ""})
      expect(json_response).to include('message')
      message = json_response['message']
      expect(message).to eq("Validation failed")
    end
  end

end