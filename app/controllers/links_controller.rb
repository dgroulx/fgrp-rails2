class LinksController < ApplicationController
  before_filter :authenticate, :set_current_park
  def index
    @link = @park.links.new
    @links = @park.links
  end

  def create
    @link = @park.links.new(params[:link])

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
  end
  
  def set_current_park
    @park ||= Park.find(params[:park_id])
  end

end
