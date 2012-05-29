require 'rho/rhocontroller'
require 'helpers/browser_helper'

class UsersController < Rho::RhoController
  include BrowserHelper

  # GET /Users
  def index
    puts "************************USERS************************"
    list_users =  get_api('users')
    puts 
    if list_users['status']=="ok"  
      @users = Rho::JSON.parse(list_users["body"])
    else 
       render  :controller=>:RhoMonitor, :action => :dashboard
    end
  end
end
