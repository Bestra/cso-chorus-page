class VoicePartsController < ApplicationController

  def index
    @parts = VoicePart.all
    render json: @parts
  end

  def show
    @part = VoicePart.find(params[:id])
    render json: @part
  end

end
