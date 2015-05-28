class Api::PostsController < ApiController
  
  before_action :find_obj, except: [:index,:create]

  def index
    @collection = Post.page(current_page)
  end

  def show
  end

  def create
    @obj = Post.new(obj_params)
    render_obj_errors unless @obj.save
  end

  def update
    render_obj_errors unless @obj.update_attributes(obj_params)
  end

  def destroy
    render_obj_errors unless @obj.destroy
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
    ))
  end

end
