class Post < ActiveRecord::Base
  # include PgSearch

  # multisearchable :against => [:title, :content]

  INDEX_DETAILS = "
    posts.id,
    posts.slug,
    posts.title,
    posts.posted_date,
    posts.excerpt,
    posts.content,
    posts.featured,
    CONCAT(creator.first_name, ' ', creator.last_name) as creator_name,
    CONCAT(updator.first_name, ' ', updator.last_name) as updator_name
  "


  SHOW_DETAILS = %w(
    posts.slug
    posts.title
    posts.posted_date
    posts.content
    posts.featured
    posts.order
  )

  scope :active, -> { where(status: 1) }
  scope :search, ->(query) { build_query if query.present? }

  belongs_to :post_category
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  belongs_to :updator, class_name: "User", foreign_key: "last_updated_by"


  after_create :update_slug

  validates :title, :post_category_id, :posted_date, :excerpt, :content, :status, presence: true
  validates :title, uniqueness: true



  def self.full_text_search query
    self.index_details.where("LOWER(title) like LOWER(?)", "%#{query}%")
    #self.index_details.where("id in (?)", PgSearch.multisearch(query).pluck(:id))
  end

  def self.index_details
   # select(INDEX_DETAILS).joins(:user).where("posts.status = 1").order("posts.id DESC")
   select(INDEX_DETAILS).from("posts inner join users creator on creator.id = posts.user_id inner join users updator on updator.id = posts.last_updated_by")
   #joins(:creator, :updator).select(INDEX_DETAILS)

  end

  def self.show_details id
    #select(SHOW_DETAILS).joins(:user).where("posts.status = 1").find(id)
    select(SHOW_DETAILS).where("posts.status = 1").active.find(id)
  end

  def author
    "#{first_name} #{last_name}"
  end

  def self.page page
   limit(10).offset((page.to_i*10) - 10)
  end

  private

  def build_query query
    query.each do |key,value|
      ""
    end
  end

  def update_slug
    #self.slug = self.id.to_s+"-"+self.title.parameterize
    update_attribute(:slug, "#{self.id}-#{self.title.parameterize}")
  end

end
