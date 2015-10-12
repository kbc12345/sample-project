class Api::MessagesController < ApiController
  
  before_action :find_obj, except: [:index,:create]

  def index
   @collection = Message.page(current_page)
   render json: {collection: @collection, metadata: metadata}
  end

  def create
    @obj = Message.new(obj_params)
    create_helper
  end

  def destroy
    delete_helper
  end

  # def update
  #   update_helper
  # end

  private

  def find_obj
    @obj = Message.find(params[:id])
  end

  def obj_params
    params.require(:message).permit(*%i(
      email
      sender
      message
    ))
  end

end
