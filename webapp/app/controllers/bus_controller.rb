class BusController < ApplicationController

  def at

    cache = Rails.cache.read(params[:id])
    data = "#{params[:lat]},#{params[:lng]}"
    
    # write to change, unless data has not chaned
    Rails.cache.write params[:id], data, :raw=>:true, :unless_exist => false, :expires_in => 5.minutes unless cache == data

    # if this is a fresh update, then return DB ID
    if cache.nil?
        bus = Bus.find_by_xref params[:id]
        # if this bus does not exist, create 
        if bus.nil?
          district = District.find_or_create_by_name params[:district] || "unknown"
          bus = Bus.find_or_create_by_name :name => params[:name] || params[:id], :district_id => district.id, :xref => params[:id]
        end
        render :json => { params[:id].to_sym => bus.id }
    else
      render :nothing => true
    end
    
  end
  
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
