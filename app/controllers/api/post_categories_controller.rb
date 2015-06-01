class Api::PostCategoriesController < ApiController
  
  before_action :find_obj, except: [:index,:create]

  def index
    @collection = PostCategory.all
  end

  def show
  end

  def create
    @obj = PostCategory.new(obj_params)
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
    @obj = PostCategory.find(params[:id])
  end


  def obj_params
    params.require(:post_category).permit(*%i(
      name
    ))
  end

end
