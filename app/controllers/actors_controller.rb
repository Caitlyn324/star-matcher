class ActorsController < ApplicationController
  def show
    @actor = current_actor
    @auditions = @actor.auditions
    @auditions = @auditions.order(:date)
  end
end
