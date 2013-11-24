class MembersOnlyController < ApplicationController
  before_filter :authenticate

  def authenticate
    redirect_to signin_path unless current_user
  end
end
