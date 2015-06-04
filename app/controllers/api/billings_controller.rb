class Api::BillingsController < ApiController

  skip_before_action :authenticate_request

  def index
    @obj = Term.first_or_create
  end

  def create
    #code that sends email stuffs
  end


end
