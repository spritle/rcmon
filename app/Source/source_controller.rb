require 'rho/rhocontroller'
require 'helpers/browser_helper'

class SourceController < Rho::RhoController
  include BrowserHelper

  # GET /Source
  def source_list
    p"----------------------------------source"
    list_sources=get_source("user")
    @sources=Rho::JSON.parse(list_sources["body"])
  end
end
