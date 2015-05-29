class Site::HomeController < SiteController


  def index

  end

  def contacts
    @message = Message.new
  end

  def works
  end

  def careers
  end

end
