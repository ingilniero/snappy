Rails.application.config.middleware.use Warden::Manager do | manager |
  manager.default_strategies :password
  manager.failure_app = lambda { |env| SessionsController.action(:new).call(env) }
end

Warden::Manager.serialize_into_session do |user|
  user.id
end

Warden::Manager.serialize_from_session do |id|
  User.find(id)
end

Warden::Strategies.add(:password) do

  def valid?
    session_params['username'] and session_params['password']
  end

  def authenticate!
    user = User.find_by(username: session_params['username'])

    if user and user.authenticate(session_params['password'])
      success! user
    else
      fail 'Your username/password was incorrect'
    end
  end

  def session_params
    params['session']
  end
end
