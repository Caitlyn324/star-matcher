class ParticipantsController < ApplicationController
  def create
    audition = Audition.find(params[:audition_id])
    participant = Participant.create(audition: audition, actor: current_actor)
    if participant.save
      redirect_to audition_path(audition), notice: "Audition added to your List"
    else
      redirect_to audition_path(audition), alert: "Audition Not Saved!"
    end
  end

  def destroy
    audition = Audition.find(params[:audition_id])
    participant = Participant.where(audition: audition, actor: current_actor).first
    if participant.destroy
      redirect_to audition_path(audition), notice: "Audition Removed from your List"
    else
      redirect_to audition_path(audition), alert: "Audition Not Removed!"
    end
  end
end
