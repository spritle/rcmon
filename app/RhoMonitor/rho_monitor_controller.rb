require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class RhoMonitorController < Rho::RhoController
  include BrowserHelper

  # GET /RhoMonitor
  def login
    if Rho::RhoConfig.token==""
      puts "Please Login..............."
    else
      puts "Please logout..............."
      render :action => :dashboard
    end
  end
  def server_login
    puts "started...................."
    server =@params['rho_monitor']['url']
    login = @params['rho_monitor']['login']
    password = @params['rho_monitor']['password']
    response= Rho::AsyncHttp.post(:url => server + "/login",
    :body => {:login => login, :password => password}.to_json,
    :headers => {"Content-Type" => "application/json"})
    
    Rho::RhoConfig.cookie = response['cookies']

    response= Rho::AsyncHttp.post(:url => server + "/api/get_api_token",
    :headers =>{"Cookie" => Rho::RhoConfig.cookie, "Content-Type" => "application/json"}
    )
    
    Rho::RhoConfig.token = response["body"]
    
    response1= Rho::AsyncHttp.post(:url => server + "/api/get_license_info",
    :body => {:api_token => Rho::RhoConfig.token}.to_json,
    :headers =>{"Cookie" => Rho::RhoConfig.cookie, "Content-Type" => "application/json"}
    )
    
    if response['status']=="ok"
      render  :action => :dashboard 
    else 
      render  :action => :login
    end
  end
  
  def dashboard
    
    puts ".............dashboard........."
    
  end
  
  def logout
    puts "---------------logout-----------"
    Rho::RhoConfig.token=""
    render :action =>:login
  end
 
end
