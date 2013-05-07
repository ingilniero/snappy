class SessionsController < ApplicationController
  def new
    flash.now[:error] = warden.message if warden.message.present?
  end

  def create
    warden.authenticate!
    redirect_to root_url
  end

  def destroy
    warden.logout
    redirect_to root_url, notice: 'You are now logged out!'
  end

  private
    def sessions_params
      params.require(:session).permit(:username, :password)
    end
end
