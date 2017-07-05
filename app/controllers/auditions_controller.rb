class AuditionsController < ApplicationController
  def index
    @auditions = Audition.all
    @actor = current_actor
  end

  def show
    @audition = Audition.find(params[:id])
    @actor = current_actor
    @actors = @audition.actors
  end

  def new # save for Director implementation
    @audition = Audition.new
    @actor = current_actor
  end

  def create # save for Director implementation
    @audition = Audition.create(strong_params)
    @audition.creator = current_actor.name
    @audition.actors << current_actor
    if @audition.save
      flash[:notice] = "Audition Posted"
      redirect_to root_path
    else
      flash[:alert] = "Audition Not Posted!"
      render 'new'
    end
  end

  def edit # save for Director implementation
    @audition = Audition.find(params[:id])
    @actor = current_actor
  end

  def update # save for Director implementation
    @audition = Audition.find(params[:id])
    if @audition.update_attributes(strong_params)
      flash[:notice] = 'Audition information updated.'
      redirect_to @audition
    else
      flash[:notice] = @audition.errors.messages
      render action: 'edit'
    end
  end

  def destroy # save for Director implementation
    @audition = Audition.find(params[:id])
    @audition.delete

    flash[:notice] = "Audition Deleted"
    redirect_to root_path
  end

  private

  def review_params
    params.require(:audition).permit(
      :roles,
      :show,
      :theater,
      :address,
      :company,
      :description,
      :equity,
      :time
    )
  end
end
