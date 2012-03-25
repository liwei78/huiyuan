# encoding: utf-8
class Message < ActiveRecord::Base
  validates :title, :presence   => true
  validates :content, :presence   => true
  
  def status
    publish? ? "已发布" : "未发布"
  end
  
end
