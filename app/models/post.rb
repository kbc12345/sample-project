class Post < ActiveRecord::Base
  # include PgSearch
  #
  # multisearchable :against => [:title, :content]

  INDEX_DETAILS = %w(
    posts.slug
    posts.title
    posts.posted_date
    posts.excerpt
    posts.featured
    posts.order
  )


  SHOW_DETAILS = %w(
    posts.slug
    posts.title
    posts.posted_date
    posts.content
    posts.featured
    posts.order
  )


  scope :active, -> { where(status: 1) }

  belongs_to :post_category
  belongs_to :user

  before_save :update_slug

  def self.full_text_search query
    self.index_details.where("LOWER(title) like LOWER(?)", "%#{query}%")
    #self.index_details.where("id in (?)", PgSearch.multisearch(query).pluck(:id))
  end

  def self.index_details
   # select(INDEX_DETAILS).joins(:user).where("posts.status = 1").order("posts.id DESC")
   select(INDEX_DETAILS).where("posts.status = 1").active.order("posts.id DESC")
  end


  def self.show_details id
    #select(SHOW_DETAILS).joins(:user).where("posts.status = 1").find(id)
    select(SHOW_DETAILS).where("posts.status = 1").active.find(id)
  end

  def author
    "#{first_name} #{last_name}"
  end

  private

  def update_slug
    self.slug = self.id.to_s+"-"+self.title.parameterize
  end

end
