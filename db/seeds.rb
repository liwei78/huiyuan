# encoding: utf-8

puts "test user"
User.create(:login => "test", :password => "1234", :password_confirmation => "1234", :name => "test")

puts "50 users"
u = 0
50.times do
  User.create(:login => "test#{u}", :password => "1234", :password_confirmation => "1234", :name => "test#{u}")
  u += 1
end

puts "Messages"
m = 0
50.times do
  Message.create(
    :title => "现价1673,最低探至1671.5,金价和昨天一样回到日内多头极限点，站稳1670上方多头再发力，还可能延续多头行情，但现在看多头极为不利。第一：近三天的反弹趋势线被跌破，第二：昨天美盘和今天一直未突破1685。建议投资者谨慎做多。", 
    :content => "现价1673,最低探至1671.5,金价和昨天一样回到日内多头极限点，站稳1670上方多头再发力，还可能延续多头行情，但现在看多头极为不利。第一：近三天的反弹趋势线被跌破，第二：昨天美盘和今天一直未突破1685。建议投资者谨慎做多。 今天密切关注：1670支撑；昨日日线低点1663支撑，前日日线低点1659支撑。")
  m += 1
end


puts "200 UserMessage"
m = 0
200.times do
  UserMessage.create(:user_id => 1, :title => "测试#{m}", :content => "内容"*30)
  m += 1
end
