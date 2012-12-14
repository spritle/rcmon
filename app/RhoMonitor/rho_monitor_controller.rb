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
    login_response= get_cookie(server,login,password)
    #puts login_response,"-----0000000000000----------------"
    # @api_token =Rho::AsyncHttp.post(:url => server + "/rc/v1/system/login",
    #       :body => {:login => login, :password => password}.to_json,
    #       :headers => {"Content-Type" => "application/json"})
    # puts  @api_token,"*************************************************************"
    Rho::RhoConfig.cookie = login_response['cookies']
    puts Rho::RhoConfig.cookie,"----------cookie--"
    Rho::RhoConfig.server=server
    response= get_token(Rho::RhoConfig.server,Rho::RhoConfig.cookie)
    #puts response,"--------------token-------------------"
    Rho::RhoConfig.token = login_response["body"]
    if login_response['status']=="ok"
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
       get_user_destroy
       get_source_destroy
       get_chart_destroy
    p "-----------get_destroy----------------"
	render :action =>:login
  end
  
  def reset
    puts "-----------------------------"
    Alert.show_popup( {
        :message => 'Are you sure want to reset database?', 
        :title => 'Database Reset', 
        :icon => '',
        :buttons => ["Yes", "No"],
        :callback => url_for(:action => :on_dismiss_popup) } )
    redirect :action => :dashboard
  end
  
  def on_dismiss_popup
    puts @params,"dismiss---------------------"
    WebView.execute_js("$.mobile.hidePageLoadingMsg();")
    if @params['button_title']=='Yes'
      response = get_api('rest')
       puts response,"response['body']----------------------"
      if response['status']=="ok" 
        get_user_destroy
        get_chart_destroy
        get_info_destroy
       # Alert.show_status("Notification", response['body'], 'OK')
       WebView.execute_js("show_dialog_box('Notification','DB is Reset','single');")
     else
      WebView.execute_js("show_dialog_box('Notification','Erorr Status','single');")
     end
    end
  end
  
  def get_adapter
    response = get_api('adapter')
     WebView.execute_js("$.mobile.hidePageLoadingMsg();")
    if response['status']=="ok" 
      #Alert.show_status("Notification", response['body'], 'OK')
      response_body=response['body']
      WebView.execute_js("show_dialog_box('Notification','#{response_body}','single');")
      #WebView.execute_js("alert('#{response_body}');")
     else 
       WebView.execute_js("show_dialog_box('Notification','Erorr Status','single');")
    end
    #redirect :action => :dashboard
  end
  
  def ping_status
    Rho::AsyncHttp.get(
    :url => Rho::RhoConfig.server,
    :callback => (url_for :action => :httpget_callback),
    :callback_params => "") 
    #redirect :action => :dashboard
  end
  
  def httpget_callback
    puts @params,"-----------------------------"
     WebView.execute_js("$.mobile.hidePageLoadingMsg();")
    if @params['status']=='ok'
      # Alert.show_popup( {
      #         :message => 'Rhoconnect server is running', 
      #         :title => 'Server Status', 
      #         :icon => '',
      #         :buttons => ["Ok"],
      #         :callback => '' } )
      WebView.execute_js("show_dialog_box('Status','Network Strength is Good','single');")
    else
      # Alert.show_popup( {
      #               :message => 'Rhoconnect server is not running', 
      #               :title => 'Server Status', 
      #               :icon => '',
      #               :buttons => ["Ok"],
      #               :callback => '' } )
      WebView.execute_js("show_dialog_box('Status','Network is Failed.Please Restart Your Network.','single');")
    end
  end
  def dashboard_refresh
    redirect :action => :dashboard
  end
end
