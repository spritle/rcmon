module BrowserHelper

  def placeholder(label=nil)
    "placeholder='#{label}'" if platform == 'apple'
  end

  def platform
    System::get_property('platform').downcase
  end

  def selected(option_value,object_value)
    "selected=\"yes\"" if option_value == object_value
  end

  def checked(option_value,object_value)
    "checked=\"yes\"" if option_value == object_value
  end

  def is_bb6
    platform == 'blackberry' && (System::get_property('os_version').split('.')[0].to_i >= 6)
  end
  
  def date_format(str)
    require 'time'
    mtime = Time.parse(str)
    mtime.strftime("%d/%m/%Y")
  end
  
  def time_format(str)
    require 'time'
    mtime = Time.parse(str)
    mtime.strftime("%H:%M %p")
  end
end