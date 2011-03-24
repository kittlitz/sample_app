class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index,:edit,:update,:destroy]
  before_filter :correct_user, :only => [:edit,:update]
  before_filter :admin_user, :only => [:destroy]

  def index
    @users = User.paginate :page => params[:page]
    @title = "All users"
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    #raise params[:user].inspect
    @user = User.new(params[:user])
    if @user.save
      # Handle successful save
      sign_in @user
      #redirect_to user_path(@user) # could also use @user[:id] as arg.
      redirect_to @user, :flash => { :success => "Welcome to the Sample App" }
    else
      @title = "Sign up"
      render :new
    end
  end

  def edit
    @title = 'Edit user'
  end

  def update
    if @user.update_attributes(params[:user])
      # it worked
      redirect_to @user, :flash => { :success => 'Profile updated.' }
    else
      @title = 'Edit user'
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    user = User.find(params[:id])
    redirect_to(root_path) if (!current_user.admin || current_user?(user))
  end
end
