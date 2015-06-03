class Post < ActiveRecord::Base

  belongs_to :post_category

  before_save :update_slug

  private

  def update_slug
    self.slug = self.id.to_s+"-"+self.title.parameterize
  end

end