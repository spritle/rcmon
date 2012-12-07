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
    #redirect :action => :index
    WebView.navigate(url_for :action => :index)
  end
  def create
    response = create_api_user(@params['user_name'],@params['user_pwd'])
    puts response,"-======================--------------------"
    response_body=response['body'].gsub("'","")
    puts response_body,"------sasa------------"
    get_user_destroy
    if response['status']=="ok" 
      puts "-----------------"
      #Alert.show_status("Notification", response['body'], 'OK')
      call_back_url='/app/Users/index'
      WebView.execute_js("show_dialog_box('Notification','#{response_body}','single','#{call_back_url}');")
      #render  :action => :wait
    elsif response['status']=="error"
      #Alert.show_status("Error", response['body'], 'OK')
      call_back_url='/app/Users/new'
     WebView.execute_js("show_dialog_box('Notification','#{response_body}','single','');")
      #render  :action => :wait
    end
    
    
  end
  
  def delete
    # Alert.show_popup( {
    #        :message => 'Are you sure want to delete'+@params['user_name']+'?', 
    #        :title => 'Delete User', 
    #        :icon => '',
    #        :buttons => ["Yes", "No"],
    #        :callback => url_for(:action => :delete_popup,:query => {:user_name=>@params['user_name']}) 
    #        })
    # redirect :action => :wait
  end
  def delete_popup
    p @params,"************delete********"
    if @params['button_title']=='Yes'
      response = delete_api_user(@params['user_name'])
      @user=Users.find(:all,:conditions => { :user => @params['user_name']})
      p @user,"-----------cc"
      #get_user_destroy
     
      @user[0].destroy
      p "-------------ddd"
      WebView.navigate(url_for :action=>:index)
    # else
    #   WebView.navigate(url_for :action=>:index)
   end
  end
  def user_dashboard
    @user=@params['user_name']
  end
  def user_dashboard_refresh
    puts @params,"================================="
    redirect :action => :user_dashboard , :query => {:user_name =>@params['user_name']}
  end
  def new_refresh
    redirect :action => :new
  end
end
