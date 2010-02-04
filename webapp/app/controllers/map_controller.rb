class MapController < ApplicationController

  def index
    
    @districts = if params.has_key? :id 
      District.find :all, :conditions => ['id = ?', params[:id]]
    else 
      District.find :all
    end
    
  end
  
  def bus
    
    @bus = Bus.find_by_xref params[:id]
    @pos = @bus.position
    redirect_to :action => :index if @bus.nil?
    redirect_to :action => :index, :id => @bus.district_id if @pos.nil?
    
  end

end
