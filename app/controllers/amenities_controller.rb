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
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @amenities }
    end
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

  def destroy
    @amenity = Amenity.find(params[:id])
    @amenity.destroy
    flash[:notice] = "#{@amenity.name} deleted."
    redirect_to amenities_path
  end
end
