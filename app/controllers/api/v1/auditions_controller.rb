class Api::V1::AuditionsController < ApplicationController
  def index
    render json: Audition.all
  end
end
