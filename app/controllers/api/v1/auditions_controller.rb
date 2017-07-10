class Api::V1::AuditionsController < ApplicationController

  def index
    if actor_signed_in?
      render json: { actor: current_actor, auditions: Audition.all, signedIn: true }
    else
      render json: { actor: Actor.where(name: 'dumb dumb').first, auditions: Audition.all, signedIn: false }
    end
  end
end
