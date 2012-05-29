require 'rho/rhocontroller'
require 'helpers/browser_helper'

class PingController < Rho::RhoController
  include BrowserHelper
  
  # GET /Ping
  def ping_form
    list_users =  get_api('users')
    @@users = Rho::JSON.parse(list_users["body"])
    list_sources=get_source("user")
    @@sources=Rho::JSON.parse(list_sources["body"])
  end
  def ping_users
    p "..............................ping!!!!"
    message=@params['rho_monitor']['message']
    vibrate=@params['rho_monitor']['vibrate']
    sound=@params['rho_monitor']['sound']
    response=get_ping(message,@@sources,vibrate,sound,@@users)
    p response,"------Response"
    Alert.show_status("Alert Box", "Sucessfully Ping following users -" +  response['body'], 'OK')
    redirect ( url_for :controller=>:RhoMonitor, :action => :dashboard ) 
  end
 
end
