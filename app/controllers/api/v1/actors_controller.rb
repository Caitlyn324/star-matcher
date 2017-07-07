class Api::V1::ActorsController < ApplicationController
  def index
    render json: current_actor
  end
end
