class Site::HomeController < SiteController


  def index
    @posts = Post.select("title,posted_date,slug").where("featured = true")
  end

end
