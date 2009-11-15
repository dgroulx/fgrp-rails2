class UsersController < Clearance::UsersController
  layout 'admin'

  # only allow logged in users to create new accounts
  skip_before_filter :redirect_to_root
  before_filter :authenticate
  
  def index
    @user = User.new
    @users = User.all
  end
  
  def create
    @user = ::User.new params[:user]
    if @user.save
      ::ClearanceMailer.deliver_confirmation @user
      flash[:notice] = "#{@user.email} will receive an email shortly to confirm their account"
      redirect_to(url_after_create)
    else
      @users = User.all
      render :action => :index
    end
  end
  
  def edit
    @user = User.find params[:id]
  end
  
  def update
    @user = ::User.find params[:id]
    if @user.update_attributes(params[:user])
      flash[:notice] = "#{@user.email} has been updated"
      redirect_to(url_after_update)
    else
      render :template => 'users/edit'
    end
  end
  
  def destroy
    @user = ::User.find params[:id]
    if User.confirmed == [@user]
      flash[:error] = "You can't delete the last confirmed user account!"
    else
      @user.destroy
      flash[:notice] = "#{@user.email} has been removed from the system"
    end
    redirect_to users_path
  end
  

  private
  
  def url_after_create
    users_path
  end

  def url_after_update
    users_path
  end
  
end
