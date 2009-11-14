class AmenitiesController < ApplicationController
  layout 'admin'
  before_filter :authenticate

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

  def edit
    @amenity = Amenity.find(params[:id])
  end

  def update
    @amenity = Amenity.find(params[:id])
    if @amenity.update_attributes(params[:amenity])
      flash[:notice] = "#{@amenity.name} was updated."
      redirect_to amenities_path
    else
      render :action => "edit"
    end
  end
end
