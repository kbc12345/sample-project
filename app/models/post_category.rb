class PostCategory < ActiveRecord::Base

  has_many :posts

  validates :name, presence: true
  validate :name_uniquness

  def self.page page
   limit(5).offset((page.to_i*5) - 5)
  end

  private

  def name_uniquness
  	if self.id.present?
  		existing_obj = PostCategory.where(name: self.name).where("id !=?", self.id)
  	else
  		existing_obj = PostCategory.where(name: self.name)
  	end
  	if existing_obj.present?
  		self.errors.add(:base, "#{existing_obj[0].name} is already taken")
  	end
  end



end