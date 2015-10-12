class Message < ActiveRecord::Base
  validates :sender, :email, :message, presence: true

  def self.page page
   limit(10).offset((page.to_i*10) - 10)
  end

end