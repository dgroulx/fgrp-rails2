class AmenitiesController < ApplicationController
  before_filter :authenticate, :except => "show"

  def new
    @amenity = Amenity.new
  end

  def create
    @amenity = Amenity.new params[:amenity]
    
    if @amenity.save
      flash[:notice] = "#{@amenity.name} was created."
      redirect_to amenities_path
    else
      render :action => "new"
    end
  end

  def index
    @amenities = Amenity.all(:order => "name ASC")
  end
end
