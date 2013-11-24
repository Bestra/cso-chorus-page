class User
  def self.from_session_token(token)
    type = Authenticator.authenticate_type(token)
    return unless type
    User.new(type == :admin ? true : false)
  end

  def initialize(admin)
    @admin = admin
  end

  def is_admin?
    @admin
  end

end
