require 'rho/rhocontroller'
require 'helpers/browser_helper'

class ChartController < Rho::RhoController
  include BrowserHelper

  # GET /Chart
  def index
    @chart=Chart.find(:all)
    p @chart,"--------------------------,,,,,,"
    if @chart == []
      puts "=============="
    @users=Users.find(:all)
    if @users == []
       list_users =  get_api('users')
     p "-----------------YES"
     if list_users['status']=="ok"  
      @users = Rho::JSON.parse(list_users["body"])
      @users.each do |user|
      @users=Users.new({:user=>user})
      @users.save
      end
      @users=Users.find(:all) 
    end
  end
    p @users,"=============userddd"
       @users.each do |user|
         @device_count=0
         list_devices =  get_device(user.user)
         @devices = Rho::JSON.parse(list_devices["body"])
           @devices.each do |device|
             @device_count=@device_count+1 
           end
         @chart=Chart.new({:user_name => user.user,:device_count =>@device_count})
         @chart.save
       end
      end
    @chart=Chart.find(:all)
    @count=[]
           @chart.each do |chart|
             count=chart.device_count.to_i 
             p chart.device_count.class,count.class 
             @count<<count
           end

  end
 def chart_refresh
   p "-------------------------------"
   get_chart_destroy
   WebView.navigate("/app/Chart/index")
 end
end