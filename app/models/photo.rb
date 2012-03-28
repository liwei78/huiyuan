class Photo < ActiveRecord::Base
  belongs_to :message
  has_attached_file :file, :default_url => "nopic.jpg"
end
