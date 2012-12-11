require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class InfoController < Rho::RhoController
  include BrowserHelper
  # GET /Info
  
  def index
     @Info=Info.find(:all)
    if @Info !=[]
       @Info=Info.find(:all)
    else
     license_info =  get_api('license')
      if license_info['status']=="ok"  
      result = Rho::JSON.parse(license_info["body"])                          
      @available = result["available"]
      @total = result["seats"]
      @issued = result["issued"]
      @license = result["licensee"]
      @issued_date =date_format(@issued)
      @issued_time =time_format(@issued)
      @Info=Info.new({:available =>@available,:total => @total,:license =>@license ,:issued_date => @issued_date })
      @Info.save
      @Info=Info.find(:all)
      else 
       render  :controller=>:RhoMonitor, :action => :dashboard
      end
     end
  end
  def info_refresh
    get_info_destroy
    #redirect :action => :index
    # WebView.execute_js("$.mobile.showPageLoadingMsg();")
    WebView.execute_js("window.location.href='/app/Info/index';")
  end 
end
