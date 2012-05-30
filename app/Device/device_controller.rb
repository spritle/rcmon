require 'rho/rhocontroller'
require 'helpers/browser_helper'

class DeviceController < Rho::RhoController
  include BrowserHelper
  # GET /Device
  def index
   @@user_name = @params['user_name']
   list_devices =  get_device(@params['user_name'])
   if list_devices['status']=="ok"  
     @devices = Rho::JSON.parse(list_devices["body"])
   else 
      redirect  :controller=>:RhoMonitor, :action => :dashboard
   end
  end

  def new
  end
  
  def create
    response = create_api_device(@params['device']['name'])
    if response['status']=="ok" 
      redirect :action => :index, :name=>@@user_name
      Alert.show_status("Notification", response['body'], 'OK')
    elsif response['status']=="error"
      Alert.show_status("Error", response['body'], 'OK')
      render  :action => :new
    end
  end
  
  def delete
    response = delete_api_device(@@user_name,@params['user_name'])
    if response['status']=="ok" 
      redirect  :action => :index, :name=>@@user_name
      Alert.show_status("Notification", response['body'], 'OK')
    end
  end
end
