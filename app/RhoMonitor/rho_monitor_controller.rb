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
    body = { :login => login, :password => password }
    p body,"------------body------------------"
    response= Rho::AsyncHttp.post(:url => "http://173.230.144.130:9292/login",
                             :body => body,
                             :headers => {"Content-Type" => "application/json"})
    p response['body'],response['cookies'],response['status'],"----------res"
    rhoconnect_session_cookie =response['cookies']
    token= Rho::AsyncHttp.post(:url => "http://173.230.144.130:9292/api/get_api_token",
                                  :headers =>{"Cookie" =>rhoconnect_session_cookie,"Content-Type" => "application/json"}
                                  )
    puts token,"---------token---------------"
    if response['status']=="ok"
      puts "true----------------"
    render  :action => :dashboard 
    else 
      puts "else-----"
      render  :action => :login
    end
  end
  def dashboard
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
