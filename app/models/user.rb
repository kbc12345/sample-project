class User < ActiveRecord::Base
  include Authenticable
  include TokenProcessor


  def set_access_token
    self.update(access_token: SecureRandom.hex(50))
  end


end