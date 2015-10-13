class Api::PostCategoriesController < ApiController
  
  before_action :find_obj, except: [:index,:create]

  def index
    render json:
          {
            collection: PostCategory.page(current_page).order("id DESC"),
            metadata: {total_page: total_page_number}
          }
  end

  def show
  end

  def create
    @obj = PostCategory.new(obj_params)
    create_helper
  end

  def update
    update_helper
  end

  def destroy
    delete_helper
  end

  private

  def total_page_number
    (PostCategory.count/5.0).ceil
  end

  def find_obj
    @obj = PostCategory.find(params[:id])
  end


  def obj_params
    params.require(:post_category).permit(*%i(
      name
    ))
  end



end
