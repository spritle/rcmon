require 'rho/rhocontroller'
require 'helpers/browser_helper'

class SourceController < Rho::RhoController
  include BrowserHelper

  # GET /Source
  def source_list
    @sources=Source.find(:all)
       p  @sources,"------------------------"
       if  @sources != []
         @sources=Source.find(:all)
        p @sources,"====================NO API=========users"
    else
      list_sources=get_source("user")
      @sources=Rho::JSON.parse(list_sources["body"])
        p @sources,"==============="
      @sources.each do |source|
      @sources=Source.new({:source=>source})
      p "==========API Calling============="
      @sources.save
      end
      @sources=Source.find(:all)
    end
  end
  def source_param
    source_params=get_source_param(@params['source_name'])
    @source_params=Rho::JSON.parse(source_params["body"])
    if @params['user_name']!=""
      list_source_docs=get_list_source_docs(@params['source_name'],@params['user_name'])
      @list_source_docs=Rho::JSON.parse(list_source_docs["body"])
    end
  end
  def source_doc
   source_db_doc=get_db_doc(@params['doc'],"hash")
   @source_db_doc=Rho::JSON.parse(source_db_doc["body"]) 
  end
  def source_refresh
    p "-----------------source refresh----------"

    get_source_destroy
    #redirect :action => :source_list
    
    WebView.navigate(url_for :action => :source_list ,:query => {:user_name =>@params['user_name']})
  end
  def source_param_refresh
    #redirect (url_for :action => :source_param,:query => {:source_name =>@params['source_name'],:user_name =>@params['user_name'] })
    WebView.navigate(url_for :action => :source_param,:query => {:source_name =>@params['source_name'],:user_name =>@params['user_name'] })
  end
  def source_doc_refresh
    # redirect (url_for :action => :source_doc ,:query => {:doc =>@params['doc'],:source_name =>@params['source_name'],:user_name =>@params['user_name']})
    WebView.navigate(url_for :action => :source_doc ,:query => {:doc =>@params['doc'],:source_name =>@params['source_name'],:user_name =>@params['user_name']})
   end
end
