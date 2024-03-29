class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method [:current_user, :logged_in?]

  protected
    def current_user
      warden.user
    end

    def warden
      request.env['warden']
    end

    def login(user)
      session[:user_id] = user.id
    end

    def logged_in?
      !current_user.nil?
    end

    def auth
      redirect_to login_url, alert: 'You must login to access that page' unless logged_in?
    end
end
