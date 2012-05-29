require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class RhoMonitorController < Rho::RhoController
  include BrowserHelper

  # GET /RhoMonitor
  def login
  end
  def server_login
    puts "started...................."
    server =@params['rho_monitor']['url']
    login = @params['rho_monitor']['login']
    password = @params['rho_monitor']['password']
    
    response= Rho::AsyncHttp.post(:url => server + "/login",
    :body => {:login => login, :password => password}.to_json,
    :headers => {"Content-Type" => "application/json"})
    
    rho_cookie = response['cookies']
    
    response= Rho::AsyncHttp.post(:url => server + "/api/get_api_token",
    :headers =>{"Cookie" => rho_cookie, "Content-Type" => "application/json"}
    )
    
    Rho::RhoConfig.token = response["body"]
    
    response1= Rho::AsyncHttp.post(:url => server + "/api/get_license_info",
    :body => {:api_token => Rho::RhoConfig.token}.to_json,
    :headers =>{"Cookie" => rho_cookie, "Content-Type" => "application/json"}
    )
    
    if response['status']=="ok"
      @raw_body = response1["body"]
      result = Rho::JSON.parse(response1["body"])
      @licensee = result["licensee"]
      @seats = result["seats"]
      @available = result["available"]
      @issue_on = result["issued"]
      
      render  :action => :dashboard 
      
    else 
      render  :action => :login
    end
  end
  
  def dashboard
    
    puts ".............dashboard........."
    
  end
  
  
  def index
    @rho_monitors = RhoMonitor.find(:all)
    render :back => '/app'
  end

  # GET /RhoMonitor/{1}
  def show
    @rho_monitor = RhoMonitor.find(@params['id'])
    if @rho_monitor
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /RhoMonitor/new
  def new
    @rho_monitor = RhoMonitor.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /RhoMonitor/{1}/edit
  def edit
    @rho_monitor = RhoMonitor.find(@params['id'])
    if @rho_monitor
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /RhoMonitor/create
  def create
    @rho_monitor = RhoMonitor.create(@params['rho_monitor'])
    redirect :action => :index
  end

  # POST /RhoMonitor/{1}/update
  def update
    @rho_monitor = RhoMonitor.find(@params['id'])
    @rho_monitor.update_attributes(@params['rho_monitor']) if @rho_monitor
    redirect :action => :index
  end

  # POST /RhoMonitor/{1}/delete
  def delete
    @rho_monitor = RhoMonitor.find(@params['id'])
    @rho_monitor.destroy if @rho_monitor
    redirect :action => :index  
  end
end
