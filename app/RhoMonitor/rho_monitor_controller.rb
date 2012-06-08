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
    response= get_cookie(server,login,password)
    Rho::RhoConfig.cookie = response['cookies']
    Rho::RhoConfig.server=server
    response= get_token(Rho::RhoConfig.server,Rho::RhoConfig.cookie)
    Rho::RhoConfig.token = response["body"]
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
    get_info_destroy
    render :action =>:login
  end
  
  def reset
    Alert.show_popup( {
        :message => 'Are you sure want to reset database?', 
        :title => 'Database Reset', 
        :icon => '',
        :buttons => ["Yes", "No"],
        :callback => url_for(:action => :on_dismiss_popup) } )
    redirect :action => :dashboard
  end
  
  def on_dismiss_popup
    if @params['button_title']=='Yes'
      response = get_api('rest')
      if response['status']=="ok" 
        Alert.show_status("Notification", response['body'], 'OK')
      end
    else
    end
  end
  
  def get_adapter
    response = get_api('adapter')
    if response['status']=="ok" 
      Alert.show_status("Notification", response['body'], 'OK')
    end
    redirect :action => :dashboard
  end
end
