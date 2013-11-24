require 'bcrypt'
class Authenticator
  include BCrypt
  u_pw = 'csc_member'
  a_pw  = 'csc_admin'
  user_password = Password.create(u_pw, cost: 1)
  admin_password = Password.create(a_pw, cost: 1)

  self.define_singleton_method :verify_password do |password|
    if user_password == password
      user_password.to_s
    elsif admin_password == password
      admin_password.to_s
    else
      nil
    end
  end

  self.define_singleton_method :authenticate_type do |token|
    return unless token

    p = Password.new(token)
    if p == a_pw
      :admin
    elsif p == u_pw
      :user
    else
      nil
    end
  end
end
