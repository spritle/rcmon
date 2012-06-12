require 'rho/rhocontroller'
require 'helpers/browser_helper'

class UsersController < Rho::RhoController
  include BrowserHelper

  # GET /Users
  def index
    @users=Users.find(:all)
    if @users != []
      p "------------------No"
      @users=Users.find(:all)
    else  
    list_users =  get_api('users')
    p "-----------------YES"
    if list_users['status']=="ok"  
      @users = Rho::JSON.parse(list_users["body"])
      @users.each do |user|
      @users=Users.new({:user=>user})
      @users.save
      end
      @users=Users.find(:all) 
    else 
       render  :controller=>:RhoMonitor, :action => :dashboard
    end
   end
   
  end
  
  def new
  end
  def user_refresh
    get_user_destroy
    redirect :action => :index
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
    Alert.show_popup( {
           :message => 'Are you sure want to delete'+@params['user_name']+'?', 
           :title => 'Delete User', 
           :icon => '',
           :buttons => ["Yes", "No"],
           :callback => url_for(:action => :delete_popup,:query => {:user_name=>@params['user_name']}) 
           })
    redirect :action => :wait
  end
  def delete_popup
    p @params,"************delete********"
    if @params['button_title']=='Yes'
      response = delete_api_user(@params['user_name'])
        p "-----------cc"
      get_user_destroy
      p "-------------ddd"
      WebView.navigate(url_for :action=>:index)
    else
      WebView.navigate(url_for :action=>:index)
   end
  end
  def user_dashboard
    @user=@params['user_name']
  end
  def user_dashboard_refresh
    redirect :action => :user_dashboard , :query => {:user_name =>@params['user_name']}
  end
  def new_refresh
    redirect :action => :new
  end
end
