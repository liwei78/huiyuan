# encoding: utf-8

puts "test user"
User.create(:login => "test", :password => "1234", :password_confirmation => "1234", :name => "test")

puts "50 users"
u = 0
50.times do
  User.create(:login => "test#{u}", :password => "1234", :password_confirmation => "1234", :name => "test#{u}")
  u += 1
end

puts "200 messages"
m = 0
200.times do
  UserMessage.create(:user_id => 1, :title => "测试#{m}", :content => "内容"*30)
  m += 1
end
