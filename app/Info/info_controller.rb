require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class InfoController < Rho::RhoController
  include BrowserHelper
  # GET /Info
  
  def index
     @Info=Info.find(:all)
     p @Info ,"///----------------"
     if @Info !=[]
       @Info=Info.find(:all)
      p "true---------------------API Call is No===========" 
     else
      p"-----------------------else"
     p "--------------------------s"
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
      p"==========API Calling==Info==========="
      @Info.save
       @Info=Info.find(:all)
      p @Info,"-----------------"
    else 
       render  :controller=>:RhoMonitor, :action => :dashboard
    end
   end
    Thread.new do
       sleep(100)
        p "**********Thread--222222222--------------------------"
       get_info_destroy
    end
  end
  
end
