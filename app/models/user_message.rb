class UserMessage < ActiveRecord::Base
  belongs_to :user
  scope :unread, :conditions => ["user_messages.read = ?", false]
  
  def readit
    update_attribute(:read, true)
  end
end
