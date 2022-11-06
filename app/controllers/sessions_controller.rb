class SessionsController < ApplicationController

  include SessionsHelper

  def new
  end

  def create
    logger.info " ++DEBUG++ #{params}"
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password_digest])
      # puts " ++DEBUG++ into_login?
      log_in(user)
      current_user
      flash[:notice] = "Login successfully."
      logger.info "++DEBUG++ Login successfully."
      logger.info "   UID: #{session[:user_id]}, UName: #{session[:user_name]}"
      redirect_to user
    else
      # Create an error message
      # puts " ++DEBUG++ login_fail?"
      # puts "++DEBUG++ notice?"
      redirect_to root_url, notice: 'Invalid username/password combination.'
      # flash[:notice] = "Invalid username/password combination."
    end
  end

  def destroy
    log_out
    redirect_to root_url, notice: 'Logged Out'
  end
end
