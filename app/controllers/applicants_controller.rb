class ApplicantsController < ApplicationController


  def create
    @applicant = Applicant.create(obj_params)


    respond_to do |format|
      if @applicant.save
        format.html { redirect_to @applicant, notice: 'Applicant was successfully created.' }
        format.js { }
      else
        format.html { render :new }
        format.json { render :error }
      end
    end
  
  end

  private


  def obj_params
    params.require(:applicant).permit(*%i(
      name
      email
      contact
      resume
    ))
  end


end
