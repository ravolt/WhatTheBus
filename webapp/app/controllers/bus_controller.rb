class BusController < ApplicationController

  def index
    
    begin      
      cache = Rails.cache.read params[:id], :raw => true
    rescue
      logger.error { "Could not retrieve #{params[:id]} from MemCache.  Check to make sure Cache service is available." }
      render :nothing => true
      return
    end

    @bus = Bus.find_by_xref params[:id]
    raise "Could not find bus '#{params[:id]}'." unless @bus

    @data = cache.split(',') if cache
    
    respond_to do |format|
      format.json {
        if @data.nil?
          render :nothing => true
        else          
          render :json => {:buses => { params[:id].to_sym => { :lat => @data[0], :lng => @data[1], :name => @bus.name, :district => @bus.district.name,   } } }
        end
      }
      format.html { 
        #default index
      }
    end        
     
  end

end
