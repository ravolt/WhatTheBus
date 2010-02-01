class Bus < ActiveRecord::Base
  
  belongs_to :district
  
  def active
    !position.nil?
  end
  
  def position
    Rails.cache.read self.xref, :raw => true
  end
  
end
