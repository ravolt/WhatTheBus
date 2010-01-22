class BusController < ApplicationController

  def at
    
    Rails.cache.write params[:id], "#{params[:lat]},#{params[:lng]},#{params[:name]},#{params[:district]}", :raw=>:true, :unless_exist => false, :expires_in => 5.minutes
    render :nothing => true
    
  end
  
  def index
    
    data = Rails.cache.read(params[:id], :raw => true).split(',')
    if data.nil?
      render :nothing => true
    else
      render :json => {:buses => { params[:id].to_sym => { :lat => data[0], :lng => data[1] } } }
     end
     
  end

end
