class Api::PostsController < ApiController
  
  before_action :find_obj, except: [:index,:create]

  def index
    @collection = Post.index_details.page(current_page)
    render json: {collection: @collection, metadata: metadata}
  end

  def show
    
  end

  def create
    @obj = Post.new(obj_params.merge({user_id: current_user.id, last_updated_by: current_user.id}))
    create_helper
  end

  def update
    obj_params.merge(last_updated_by: current_user.id)
    update_helper
  end

  def destroy
    delete_helper
  end

  private

  def find_obj
    @obj = Post.find(params[:id])
  end

  def obj_params
    params.require(:post).permit(*%i(
      title
      slug
      excerpt
      content
      author
      status
      posted_date
      post_category_id
      tags
      featured
      order
      last_updated_by
    ))
  end 

end
