class BusController < ApplicationController

  def at
    
    Rails.cache.write params[:id], "#{params[:lat]},#{params[:lng]},#{params[:name]},#{params[:district]}", :raw=>:true, :unless_exist => false, :expires_in => 5.minutes
    render :nothing => true
    
  end
  
  def index
    
    begin
      
      # get data from cache
      @data = Rails.cache.read(params[:id], :raw => true).split(',')
      
      if @data.nil?
        render :nothing => true
      else
        respond_to do |format|
          format.json {
            render :json => {:buses => { params[:id].to_sym => { :lat => @data[0], :lng => @data[1] } } }
          }
          format.html { 
            #default
          }
        end
      end
        
    rescue
      logger.error { "Could not retrieve #{params[:id]} from MemCache.  Check to make sure Cache service is available." }
      render :nothing => true
    end
     
  end

end
