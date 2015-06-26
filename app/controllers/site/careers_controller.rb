class Site::CareersController < SiteController


  def index
    @applicant = Applicant.new
  end


end
