require 'rho/rhocontroller'
require 'helpers/browser_helper'

class UsersController < Rho::RhoController
  include BrowserHelper

  # GET /Users
  def index
    @users=Users.find(:all)
    p @users,"------------------------"
    if @users != []
      @users=Users.find(:all)
     p @users,"====================NO API=========users"
    else  
    list_users =  get_api('users')
    if list_users['status']=="ok"  
      @users = Rho::JSON.parse(list_users["body"])
      @users.each do |user|
      @users=Users.new({:user=>user})
      p"==========API Calling============="
      @users.save
      end
      @users=Users.find(:all) 
    else 
       render  :controller=>:RhoMonitor, :action => :dashboard
    end
   end
    Thread.new do
      sleep(100)
      p "**********Thread--1--------------------------"
      get_user_destroy
   end
  end
  
  def new
  end
  
  def create
    response = create_api_user(@params['users']['name'],@params['users']['password'])
    if response['status']=="ok" 
      Alert.show_status("Notification", response['body'], 'OK')
    elsif response['status']=="error"
      Alert.show_status("Error", response['body'], 'OK')
      render  :action => :new
    end
    get_user_destroy
    redirect :action => :index
  end
  
  def delete
    response = delete_api_user(@params['name'])
    if response['status']=="ok" 
      Alert.show_status("Notification", response['body'], 'OK')
    end
    get_user_destroy
    redirect :action => :index
  end
  
  def user_dashboard
    @user=@params['name']
  end
end
