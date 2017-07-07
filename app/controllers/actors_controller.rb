class ActorsController < ApplicationController
  def show
    @actor = current_actor
    auditions = @actor.auditions
    auditions.sort_by { |aud| aud.date }
    @past_auditions = auditions.find_all { |audition| audition.date < Time.now() }
    @past_auditions = @past_auditions.sort_by { |aud| aud.date }
    @future_auditions = auditions.find_all { |audition| audition.date >= Time.now() }
    @future_auditions = @future_auditions.sort_by { |aud| aud.date }
  end
end
