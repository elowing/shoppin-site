class SessionsController < ApplicationController

  def create
    @user = User.find_by_provider_and_uid(auth_hash[:provider], auth_hash[:uid]) || User.create_with_omniauth(auth_hash)
    session[:user_id] = @user.id
    session[:current_user] = @user
    flash[:notice] = "Thanks for signing in!"
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def auth_hash
    env['omniauth.auth']
  end

end