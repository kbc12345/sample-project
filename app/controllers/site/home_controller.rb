class Site::HomeController < SiteController


  def index
    @posts = Post.select("title,posted_date,slug").where("featured = true")
  end

  def about
  end
  
  def contacts
    @message = Message.new
  end

  def works
  end

  def careers
    @applicant = Applicant.new
  end

end
