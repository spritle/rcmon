require 'rho/rhocontroller'
require 'helpers/browser_helper'

class SourceController < Rho::RhoController
  include BrowserHelper

  # GET /Source
  def source_list
    list_sources=get_source("user")
    @sources=Rho::JSON.parse(list_sources["body"])
  end
  def source_param
    source_params=get_source_param(@params['source_name'])
    @source_params=Rho::JSON.parse(source_params["body"])
    if @params['user_name']!=""
      list_source_docs=get_list_source_docs(@params['source_name'],@params['user_name'])
      @list_source_docs=Rho::JSON.parse(list_source_docs["body"])
    end
  end
end
