class Site::ContactController < SiteController


  def index
    @message = Message.new
  end


end
