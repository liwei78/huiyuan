module ApplicationHelper
  def site_title
    SITE_SETTINGS["site_title"]
  end
  
  ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
    errors = Array(instance.error_message).join(', ')
    %(#{html_tag}<span class="validation-error">&nbsp;#{errors}</span>).html_safe
  end
  
  def nbsp(n=1)
    raw "&nbsp;"*n
  end
  
  def admin_nav?(flag)
    'on' if flag == @admin_nav_flag
  end
  
  def js_void
    "javascript:void(0);"
  end

  def loggin?
    session[:signcode]||cookies[:signcode] ? true : false
  end
  
  def current_li(li_name)
    str = ''
    case li_name
    when 'show'
      str = "current" if li_name == action_name
    when 'find'
      str = "current" if li_name == action_name
    end
    str
  end
  
end
