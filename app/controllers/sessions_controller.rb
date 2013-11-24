class SessionsController < ApplicationController
  def new
  end

  def create
    token = Authenticator.verify_password(params[:session][:password])
      # Sign the user in and redirect to the user's show page.
    if token
      sign_in(token)
      redirect_to root_path
    else
      flash.now[:error] = 'Invalid password'
      render 'new'
    end
  end

  def destroy
    session[:token] = nil
    current_user = nil
    redirect_to signin_path
  end
end
