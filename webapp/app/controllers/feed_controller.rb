class FeedController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def bus

    cache = Rails.cache.read params[:id], :raw => true
    data = "#{params[:lat]},#{params[:lng]}"
    
    logger.debug { "cache for '#{params[:id]}' was '#{cache}' will be '#{data}'" }
  
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

end