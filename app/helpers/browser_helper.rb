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
  def get_cookie(server,login,password)
    Rho::AsyncHttp.post(:url => server + "/login",
          :body => {:login => login, :password => password}.to_json,
          :headers => {"Content-Type" => "application/json"})
  end
  def get_token(server,cookie)
    Rho::AsyncHttp.post(:url => server + "/api/get_api_token",
                        :headers =>{"Cookie" => cookie, "Content-Type" => "application/json"}
                      )
    
    end
  def get_api(str)
    if str == 'license'
      request_url = Rho::RhoConfig.server + "/api/get_license_info"
    elsif str == 'user'
      request_url =''
    end
    Rho::AsyncHttp.post( :url => request_url,
                         :body => {:api_token => Rho::RhoConfig.token}.to_json,
                         :headers => {"Content-Type" => "application/json","Cookie" => Rho::RhoConfig.cookie}
                       )
  end
end