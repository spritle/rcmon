require 'rho/rhocontroller'
require 'helpers/browser_helper'

class PingController < Rho::RhoController
  include BrowserHelper
  
  # GET /Ping
  def ping_form
    list_users =  get_api('users')
    @@users = Rho::JSON.parse(list_users["body"])
  end
  def ping_users
    p "..............................ping!!!!"
    sources=@params['rho_monitor']['source']
    message=@params['rho_monitor']['message']
    vibrate=@params['rho_monitor']['vibrate']
    sound=@params['rho_monitor']['sound']
    response=get_ping(message,sources,vibrate,sound,@@users)
    p response,"------Response"
    redirect ( url_for :controller=>:RhoMonitor, :action => :dashboard ) 
  end
 
end
