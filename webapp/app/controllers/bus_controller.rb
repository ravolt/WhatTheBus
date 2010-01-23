class BusController < ApplicationController

  def at

    not_in_cache = Rails.cache.read(params[:id]).nil?
    
    Rails.cache.write params[:id], "#{params[:lat]},#{params[:lng]}", :raw=>:true, :unless_exist => false, :expires_in => 5.minutes

    # if this is a fresh update, then return DB ID
    if not_in_cache
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
      
      # get data from cache
      @data = Rails.cache.read(params[:id], :raw => true).split(',')
      @bus = Bus.find_by_xref params[:id]
      
        respond_to do |format|
          if @data.nil?
            render :nothing => true
          else
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
        
    rescue
      logger.error { "Could not retrieve #{params[:id]} from MemCache.  Check to make sure Cache service is available." }
      render :nothing => true
    end
     
  end

end
