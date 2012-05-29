require 'rho/rhocontroller'
require 'helpers/browser_helper'

class UsersController < Rho::RhoController
  include BrowserHelper

  # GET /Users
  def index
    list_users =  get_api('users')
    if list_users['status']=="ok"  
      @users = Rho::JSON.parse(list_users["body"])
    else 
       render  :controller=>:RhoMonitor, :action => :dashboard
    end
  end
  
  def new
  end
  
  def create
    response = create_api_user(@params['users']['name'],@params['users']['password'])
    if response['status']=="ok" 
      render  :controller=>:RhoMonitor, :action => :dashboard
      Alert.show_status("Notification", response['body'], 'OK')
    elsif response['status']=="error"
      Alert.show_status("Error", response['body'], 'OK')
      render  :action => :new
    end
    redirect :action => :index
  end
  
  def delete
    response = delete_api_user(@params['name'])
    if response['status']=="ok" 
      render  :controller=>:RhoMonitor, :action => :dashboard
      Alert.show_status("Notification", response['body'], 'OK')
    end
    redirect :action => :index
  end
end
