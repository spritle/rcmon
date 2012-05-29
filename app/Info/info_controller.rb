require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class InfoController < Rho::RhoController
  include BrowserHelper
  @@server_url = "http://173.230.144.130:9292"
  @@login = "rhoadmin"
  @@password = ""
  # GET /Info
  
  def index
    puts "******************INFO***********************"
    body = { :login => "#{@@login}", :password => "#{@@password}" }.to_json
    
    response =  Rho::AsyncHttp.post(:url => "#{@@server_url}/login",
                                    :body => body,
                                    :headers => {"Content-Type" => "application/json"}
                                    )
    rho_cookie = response['cookies']
    
    token = Rho::AsyncHttp.post(:url => "#{@@server_url}/api/get_api_token",
                         :headers => {"Content-Type" => "application/json", "Cookie" => rho_cookie}
                       )
    Rho::RhoConfig.token = response["body"]                   
    @token = token["body"]   
   
    license_info =  Rho::AsyncHttp.post(:url => "#{@@server_url}/api/get_license_info",
                                        :body => {:api_token => Rho::RhoConfig.token}.to_json,
                                        :headers => {"Content-Type" => "application/json","Cookie" => rho_cookie}
                                        )
    
    if response['status']=="ok"  
      
      result = Rho::JSON.parse(license_info["body"])                          
      @available = result["available"]
      @total = result["seats"]
      @issued = result["issued"]
      @license = result["licensee"]
      @issued_date =date_format(@issued)
      @issued_time =time_format(@issued)
    else 
       render  :controller=>"rho_monitor", :action => :login
    end
  end
  
end
