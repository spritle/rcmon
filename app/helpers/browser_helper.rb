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
  def get_device(username)
    Rho::AsyncHttp.post( :url => Rho::RhoConfig.server + "/api/list_clients",
                                 :body => {:api_token => Rho::RhoConfig.token, 'user_id' => username}.to_json,
                                 :headers => {"Content-Type" => "application/json","Cookie" => Rho::RhoConfig.cookie}
                            )
  end  
    
  def create_api_device(username)
      Rho::AsyncHttp.post( :url => Rho::RhoConfig.server + "/api/create_client",
                               :body => {:api_token => Rho::RhoConfig.token, 'user_id' => username}.to_json,
                               :headers => {"Content-Type" => "application/json","Cookie" => Rho::RhoConfig.cookie}
                          )
  end
  
  def delete_api_device(username,device)
    Rho::AsyncHttp.post( :url => Rho::RhoConfig.server + "/api/delete_client",
                                   :body => {:api_token => Rho::RhoConfig.token, 'user_id' => username,'client_id' =>device}.to_json,
                                   :headers => {"Content-Type" => "application/json","Cookie" => Rho::RhoConfig.cookie}
                       )
  end
  
  def create_api_user(username,password)
    Rho::AsyncHttp.post( :url => Rho::RhoConfig.server + "/api/create_user",
                             :body => {:api_token => Rho::RhoConfig.token, :attributes =>{'login' => username, 'password' => password}}.to_json,
                             :headers => {"Content-Type" => "application/json","Cookie" => Rho::RhoConfig.cookie}
                        )
  end
  
  def delete_api_user(username)
    Rho::AsyncHttp.post( :url => Rho::RhoConfig.server + "/api/delete_user",
                                 :body => {:api_token => Rho::RhoConfig.token, 'user_id' => username}.to_json,
                                 :headers => {"Content-Type" => "application/json","Cookie" => Rho::RhoConfig.cookie}
                            )
  end
  

  def get_api(str)
    if str == 'license'
      request_url = Rho::RhoConfig.server + "/api/get_license_info"
    elsif str == 'users'
      request_url =  Rho::RhoConfig.server + "/api/list_users"
    end
    Rho::AsyncHttp.post( :url => request_url,
                         :body => {:api_token => Rho::RhoConfig.token}.to_json,
                         :headers => {"Content-Type" => "application/json","Cookie" => Rho::RhoConfig.cookie}
                       )
  end
  def get_ping(message,sources,vibrate,sound,users)
    Rho::AsyncHttp.post( :url => Rho::RhoConfig.server+"/api/ping",
                         :body => {:api_token => Rho::RhoConfig.token, :user_id => users,:sources => sources ,:message => message,:vibrate => vibrate,:sound => sound}.to_json,
                         :headers => {"Content-Type" => "application/json","Cookie" => Rho::RhoConfig.cookie}
                   )
 
  end
  def get_source(partition)
    Rho::AsyncHttp.post( :url => Rho::RhoConfig.server+"/api/list_sources",
                         :body => {:api_token => Rho::RhoConfig.token, :partition_type =>partition}.to_json,
                         :headers => {"Content-Type" => "application/json","Cookie" => Rho::RhoConfig.cookie}
                       )
  end
  def get_source_param(source)
    Rho::AsyncHttp.post( :url => Rho::RhoConfig.server+"/api/get_source_params",
                         :body => {:api_token => Rho::RhoConfig.token,:source_id => source}.to_json,
                         :headers => {"Content-Type" => "application/json","Cookie" => Rho::RhoConfig.cookie}
                       )
  end
  def get_list_source_docs(source,user)
    Rho::AsyncHttp.post( :url => Rho::RhoConfig.server+"/api/list_source_docs",
                         :body => {:api_token => Rho::RhoConfig.token,:source_id => source,:user_id => user}.to_json,
                         :headers => {"Content-Type" => "application/json","Cookie" => Rho::RhoConfig.cookie}
                       )
 end
 def get_db_doc(doc,data_type)
   Rho::AsyncHttp.post( :url => Rho::RhoConfig.server+"/api/get_db_doc",
                        :body => {:api_token => Rho::RhoConfig.token, :doc => doc,:data_type => data_type }.to_json,
                        :headers => {"Content-Type" => "application/json","Cookie" => Rho::RhoConfig.cookie}
                      )
 end
end