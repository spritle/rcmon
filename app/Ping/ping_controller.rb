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
          end
        end
    end
  
  def ping_form
    p @params,"-------------------------o-o"
    @@users=[]
    if @params != {}
    @params['ping'].each do |key,value|
       @@users << value
    end
   end
    @users=@@users
  end
  def ping_users
   
    message=@params['ping_mgs']
    vibrate=@params['ping_vibrate']
    sound=@params['ping_sound']

    list_sources=get_source("user")
    sources=Rho::JSON.parse(list_sources["body"])
    response=get_ping(message,sources,vibrate,sound,@@users)
    # Alert.show_status("Alert Box", "Sucessfully Ping following users -" +  response['body'], 'OK')
    response_body=response['body']
    WebView.execute_js("$.mobile.hidePageLoadingMsg();")
    WebView.execute_js("show_dialog_box('Notification','Sucessfully Ping following users #{response_body}','single','/app/RhoMonitor/dashboard');")
  
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
