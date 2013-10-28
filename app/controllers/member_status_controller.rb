class MemberStatusController < ApplicationController

  def show
    @status = MemberStatus.find(params[:id])

    render json: @status
  end
end
