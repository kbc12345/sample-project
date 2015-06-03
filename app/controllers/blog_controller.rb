class BlogController < ApplicationController

 # before_action :find_post, only: :show

  layout 'blog'
  
  def index
    @posts = Post.index_details
  end

  def show
    @post = Post.show_details(params[:id].split('-')[0])
  end

  def search
  end


  
end