class LinksController < ApplicationController
  layout 'admin'
  before_filter :authenticate, :set_current_park
  
  def index
    @link = @park.links.new
    @links = @park.links
  end

  def create
    @link = @park.links.new(params[:link])
    @links = []

    respond_to do |format|
      if @link.save
        flash[:success] = 'Link was successfully created.'
        format.html { redirect_to :action => 'index' }
      else
        format.html { render :action => 'index' }
      end
    end
  end

  def edit
    @link = @park.links.find(params[:id])
  end

  def update
    @link = @park.links.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        flash[:success] = 'Link was successfully updated.'
        format.html { redirect_to(park_links_path(@park)) }
        format.xml  { head :ok }
      else
        format.html { render :action => 'edit' }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @link = @park.links.find(params[:id])
    @link.destroy

    flash[:success] = 'Link was successfully destroyed.'

    respond_to do |format|
      format.html { redirect_to park_links_path(@park) }
    end
  end
  
  def set_current_park
    @park ||= Park.find(params[:park_id])
  end

end
