require 'rho/rhocontroller'
require 'helpers/browser_helper'

class PingController < Rho::RhoController
  include BrowserHelper
  
  # GET /Ping
  def index
    list_users =  get_api('users')
    if list_users['status']=="ok"  
      @users = Rho::JSON.parse(list_users["body"])
    else 
       render  :controller=>:RhoMonitor, :action => :dashboard
    end
  end
  
  def ping_form
    puts "SSSSSSSSSSSSSSSSSSSS"
    puts @params.inspect
    list_users =  get_api('users')
    @users = Rho::JSON.parse(list_users["body"])
    @@users=[]
    @users.each do |user|
      if @params[user] == "on"
        @@users << user
      end
    end
  end
  
  def ping_users
    p "..............................ping!!!!"
    message=@params['rho_monitor']['message']
    vibrate=@params['rho_monitor']['vibrate']
    sound=@params['rho_monitor']['sound']

    list_sources=get_source("user")
    sources=Rho::JSON.parse(list_sources["body"])
    response=get_ping(message,sources,vibrate,sound,@@users)
    p response,"------Response"
    Alert.show_status("Alert Box", "Sucessfully Ping following users -" +  response['body'], 'OK')
    redirect ( url_for :controller=>:RhoMonitor, :action => :dashboard ) 
  end
 
end
