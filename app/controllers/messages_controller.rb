class MessagesController < ApplicationController


  def create
    Message.create(obj_params)

    render :nothing => true, :status => 200, :content_type => 'text/html'

    # respond_to do |format|
    #   if @message.save
    #     format.html { redirect_to @message, notice: 'High score was successfully created.' }
    #     format.json { render :show, status: :created, location: @message }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @message.errors, status: :unprocessable_entity }
    #   end
    # end
    
  end

  private


  def obj_params
    params.require(:message).permit(*%i(
      sender
      email
      message
    ))
  end


end
