require 'rho/rhocontroller'
require 'helpers/browser_helper'
require 'json'

class InfoController < Rho::RhoController
  include BrowserHelper
  # GET /Info
  
  def index
    license_info =  get_api('license')
    
    if license_info['status']=="ok"  
      result = Rho::JSON.parse(license_info["body"])                          
      @available = result["available"]
      @total = result["seats"]
      @issued = result["issued"]
      @license = result["licensee"]
      @issued_date =date_format(@issued)
      @issued_time =time_format(@issued)
    else 
       render  :controller=>:RhoMonitor, :action => :dashboard
    end
  end
  
end
