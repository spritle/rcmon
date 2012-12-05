require 'rho/rhocontroller'
require 'helpers/browser_helper'

class ChartController < Rho::RhoController
  include BrowserHelper

  # GET /Chart
  def index
    @chart=Chart.find(:all)
    p @chart,"--------------------------,,,,,,"
    if @chart == []
    @user=Users.find(:all)
    p @user,"=============userddd"
       @user.each do |user|
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