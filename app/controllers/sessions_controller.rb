class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      # Tell flash to only appear on current render, rather than on
      # next request.
      flash.now[:error] = "Invalid email/password combination"
      @title = "Sign in"
      render 'new'
    else
      # handle success.
      sign_in user
      redirect_to user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
