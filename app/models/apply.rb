# encoding: utf-8
class Apply < ActiveRecord::Base
  validates :name, :presence   => true
  validates :phone, :presence   => true
  validates :address, :presence   => true
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, 
    :presence   => true,
    :format     => {:with => email_regex}
end
