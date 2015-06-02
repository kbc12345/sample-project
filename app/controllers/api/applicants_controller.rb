class Api::ApplicantsController < ApiController
  
  before_action :find_obj, except: [:index,:create]

  def index
    @collection = Applicant.page(current_page)
  end


  def destroy
    render_obj_errors unless @obj.destroy
  end

  private

  def find_obj
    @obj = Applicant.find(params[:id])
  end



end
