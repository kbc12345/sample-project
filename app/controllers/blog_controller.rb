class BlogController < ApplicationController

  before_action :find_post, only: :show

  layout 'blog'
  
  def index
  end

  def show
    
  end

  def search
  end

  private

  def find_post
    @post = Post.find(params[:id].split('-')[0])
  end
  
end