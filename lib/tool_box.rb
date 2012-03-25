require 'digest'

class ToolBox
  SITE_SETTINGS = YAML.load_file(File.join(Rails.root.to_s, "config", "site_settings.yml"))[Rails.env]
  @@key = SITE_SETTINGS["admin_key"]
  @@acc = SITE_SETTINGS["admin_account"]
  @@pwd = SITE_SETTINGS["admin_password"]
  
  def self.check_login(account, password)
    hash(account) == hash(@@acc) and hash(password) == hash(@@pwd)
  end
  
  def self.adminnow
    puts "copy and paste in admin.yml"
    puts "- "*50
    puts "# updated at #{Time.now.to_s}"
    puts "admin_key:      #{hash(@@key)}"
    puts "admin_account:  #{hash(@@acc)}"
    puts "admin_password: #{hash(@@pwd)}"
  end
  
  def self.admin_login?(login_key)
    login_key and (login_key == @@key)
  end
  
  def self.admin_key
    @@key
  end
  
  private
  
  def self.hash(str)
    Digest::SHA2.hexdigest(str)
  end
  
end