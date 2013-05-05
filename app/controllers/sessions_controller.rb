class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: sessions_params[:username])

    if user and user.authenticate(sessions_params[:password])
      login user
      flash[:success] = 'You are now logged in!'
      redirect_to root_url
    else
      flash.now[:error] = 'Your username/password was incorrect'
      render 'new'
    end
  end

  private
    def sessions_params
      params.require(:session).permit(:username, :password)
    end
end
