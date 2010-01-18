class BusController < ApplicationController

  def at
    
    Rails.cache.write params[:id], "#{params[:ll]},#{params[:name]},#{params[:district]}", :unless_exist => false, :expires_in => 5.minutes
    render :nothing => true
    
  end
  
  def index
    
    data = Rails.cache.read(params[:id], :raw => true).split(',')
    render :json => { :bus => { :lat => data[0], :lng => data[1], :name => data[2], :district => data[3] } }
     
  end

end
