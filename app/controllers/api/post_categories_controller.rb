class Api::V1::PostsController < ApiController
  
  before_action :find_obj, except: [:index,:create]

  def index
    @collection = current_user.posts.search(search_query).page(current_page)
  end

  def show
  end

  def create
    @obj = current_user.company.posts.new(obj_params)
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
    @obj = current_user.posts.find(params[:id])
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
