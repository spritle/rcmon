require 'rho/rhocontroller'
require 'helpers/browser_helper'

class DeviceController < Rho::RhoController
  include BrowserHelper

  # GET /Device
  def index
   puts "*****************Device*88888888888"
   puts @params.inspect
    @devices=[]
  end

  # GET /Device/{1}
  def show
    @device = Device.find(@params['id'])
    if @device
      render :action => :show, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # GET /Device/new
  def new
    @device = Device.new
    render :action => :new, :back => url_for(:action => :index)
  end

  # GET /Device/{1}/edit
  def edit
    @device = Device.find(@params['id'])
    if @device
      render :action => :edit, :back => url_for(:action => :index)
    else
      redirect :action => :index
    end
  end

  # POST /Device/create
  def create
    @device = Device.create(@params['device'])
    redirect :action => :index
  end

  # POST /Device/{1}/update
  def update
    @device = Device.find(@params['id'])
    @device.update_attributes(@params['device']) if @device
    redirect :action => :index
  end

  # POST /Device/{1}/delete
  def delete
    @device = Device.find(@params['id'])
    @device.destroy if @device
    redirect :action => :index  
  end
end
