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
    body = { :login => "#{@@login}", :password => "#{@@password}" }.to_json
    
    response =  Rho::AsyncHttp.post(:url => "#{@@server_url}/login",
                                    :body => body,
                                    :headers => {"Content-Type" => "application/json"}
                                    )
    rhoconnect_session_cookie = response["cookies"]
      
    
    
    token = Rho::AsyncHttp.post(:url => "#{@@server_url}/api/admin/get_api_token",
                         :body => body,
                         :headers => {"Content-Type" => "application/json","Cookie" => rhoconnect_session_cookie}
                       )
                       
    
    
    @token = token["body"]   
   
    license_info =  Rho::AsyncHttp.post(:url => "#{@@server_url}/api/admin/get_license_info",
                                        :body => body,
                                        :headers => {"Content-Type" => "application/json",:api_token => @token}
                                        )
                                
    @available = license_info["body"]["available"]
    @total = license_info["body"]["seats"]
    @issued = license_info["body"]["issued"]
    @licensee = license_info["body"]["license"]


    #render :back => '/app'
  end
  
end
