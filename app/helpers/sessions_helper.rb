module SessionsHelper

  def sign_in(token)
    session[:token] = token

    self.current_user = User.from_session_token(token)
  end

  def signed_in?
    @current_user
  end

  def is_admin?
    current_user.try(:is_admin?)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.from_session_token(session[:token])
  end
end
