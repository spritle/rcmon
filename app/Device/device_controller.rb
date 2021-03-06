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
    puts response,"---------------------------------"
    if response['status']=="ok" 
      redirect :action => :index, :query =>{:user_name=>@@user_name}
      Alert.show_status("Notification", response['body'], 'OK')
    elsif response['status']=="error"
      Alert.show_status("Error", response['body'], 'OK')
      render  :action => :new
    end
  end
  
  def delete
   # puts @params,"================="
     response = delete_api_device(@@user_name,@params['device_name'])
     if response['status']=="ok" 
       redirect  :action => :index, :query =>{:user_name=>@@user_name}
       Alert.show_status("Notification", response['body'], 'OK')
     end
  end
  
  def device_param
    @device_name = @params['device_name']
    response = get_device_param(@params['device_name'])
    if response['status']=="ok" 
      @device_params=Rho::JSON.parse(response["body"])
    else
      @device_params=[]
    end
  end
  def device_refresh
    get_devices_destroy
    #redirect  :action => :index, :query =>{:user_name=>@@user_name}
    WebView.navigate(url_for :action => :index, :query =>{:user_name=>@@user_name} )
  end
  def device_params_refresh 
    #redirect  :action => :device_param, :query => {:device_name =>  @params['device_name'],:user_name=> @params['user_name']}
     WebView.navigate(url_for :action => :device_param, :query => {:device_name =>  @params['device_name'],:user_name=> @params['user_name']} )
  end
  def new_refresh
    redirect  :action => :new, :query =>{:user_name=>@@user_name}
  end
end
