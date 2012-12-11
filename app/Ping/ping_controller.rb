require 'rho/rhocontroller'
require 'helpers/browser_helper'

class PingController < Rho::RhoController
  include BrowserHelper
  
  # GET /Ping
  def index
      @users=Users.find(:all)
         if @users != []
           @users=Users.find(:all)
         else  
         list_users =  get_api('users')
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
  
  def ping_form
    p @params['users'],@params['users'].class,"-------------------------o-o"
    @@users=@params['users'].split(',')
    # @users=Users.find(:all)
    # @@users=[]
    # @users.each do |user|

    #   if @params[user] == "on"
    #     puts user,"======"
    #     @@users << user
    #   end
    # end
     # puts @@users,"==================="
     # @user_list = @@users
     # puts  @user_list,"=--=-=-=-=-=-=-=-=-=-=-="
  end
  def ping_users

    message=@params['rho_monitor']['message']
    vibrate=@params['rho_monitor']['vibrate']
    sound=@params['rho_monitor']['sound']

    list_sources=get_source("user")
    sources=Rho::JSON.parse(list_sources["body"])
    response=get_ping(message,sources,vibrate,sound,@@users)
    Alert.show_status("Alert Box", "Sucessfully Ping following users -" +  response['body'], 'OK')
    redirect ( url_for :controller=>:RhoMonitor, :action => :dashboard ) 
  end
  def ping_user_refresh
    get_user_destroy
    # redirect :action => :index
    WebView.navigate("/app/Ping/index")
  end
  def ping_form_refresh
    redirect :action => :index 
  end
end
