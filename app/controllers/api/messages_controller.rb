class Api::MessagesController < ApiController
  
  before_action :find_obj, except: [:index,:create]

  def index
    @collection = Message.page(current_page)
  end


  def destroy
    render_obj_errors unless @obj.destroy
  end

  private

  def find_obj
    @obj = Message.find(params[:id])
  end



end
