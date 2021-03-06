class User < ActiveRecord::Base
  include Authenticable

  has_many :updated_post, class_name: "Post", foreign_key: "last_updated_by"
  has_many :created_post, class_name: "Post", foreign_key: "user_id"
  # current_user.posts.create

  validates :email, presence: true,  uniqueness: true
  validate :validate_password_presence
  validate :validate_password_length

  def validate_password_presence
    if (new_record? && @password.blank?) || (!@password.nil? && @password.empty?)
      errors.add(:password, "can't be blank")
    end
  end

  def validate_password_length
    if @password.present? && @password.length < 8
      errors.add(:password, 'must be at least 8 characters')
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def set_access_token
    self.update(access_token: SecureRandom.hex(50))
  end

  def destroy_access_token
    self.update(access_token: nil)
  end

  def self.index_details
    select("first_name", "last_name", "email", "access_token")
  end

  def self.page page
    limit(10).offset((page.to_i*10) - 10)
  end

  def self.find_by_credentials(creds)
    user = self.find_by_email(creds[:email])
    user if user.present? && user.valid_password?(creds[:password])
  end



end