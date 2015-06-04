class Api::TermsController < ApiController


  def index
    @obj = Term.first_or_create
  end

  def update
    Term.first.update_attribute(:content, params[:content])
  end


end
