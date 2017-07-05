class ActorsController < ApplicationController
  def show
    @actor = current_actor
    @auditions = @actor.auditions
  end
end
