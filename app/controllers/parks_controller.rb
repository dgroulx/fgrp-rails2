class ParksController < ApplicationController
  layout "admin", :except => ["show"]
  before_filter :authenticate, :except => ['show', 'index']
  before_filter :authenticate_unless_json, :only => ['index']
  
  # GET /parks
  # GET /parks.xml
  def index
    @parks = Park.scoped(:order => "name")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @parks }
      format.json  { render :json => ParksPresenter.new(@parks) }
    end
  end

  # GET /parks/1
  # GET /parks/1.xml
  def show
    @park = Park.find(params[:id])

    respond_to do |format|
      format.html { render :action => "show", :layout => "application" }
      format.xml  { render :xml => @park }
    end
  end

  # GET /parks/new
  # GET /parks/new.xml
  def new
    @park = Park.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @park }
    end
  end

  # GET /parks/1/edit
  def edit
    @park = Park.find(params[:id])
  end

  # POST /parks
  # POST /parks.xml
  def create
    @park = Park.new(params[:park])

    respond_to do |format|
      if @park.save
        flash[:success] = 'Park was successfully created.'
        format.html { redirect_to(parks_path) }
        format.xml  { render :xml => @park, :status => :created, :location => @park }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @park.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /parks/1
  # PUT /parks/1.xml
  def update
    @park = Park.find(params[:id])

    respond_to do |format|
      if @park.update_attributes(params[:park])
        flash[:success] = 'Park was successfully updated.'
        format.html { redirect_to(parks_path) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @park.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /parks/1
  # DELETE /parks/1.xml
  def destroy
    @park = Park.find(params[:id])
    @park.destroy

    flash[:success] = "Park was successfully destroyed."

    respond_to do |format|
      format.html { redirect_to(parks_url) }
      format.xml  { head :ok }
    end
  end
  
  def authenticate_unless_json
    authenticate unless request.format.to_s == 'application/json'
  end
end
