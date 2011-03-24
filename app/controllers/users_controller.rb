class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit,:update]

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
    @user = User.find(params[:id])
    @title = 'Edit user'
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # it worked
      redirect_to @user, :flash => { :success => 'Profile updated.' }
    else
      @title = 'Edit user'
      render 'edit'
    end
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

end
