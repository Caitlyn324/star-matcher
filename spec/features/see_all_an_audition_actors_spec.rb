require 'rails_helper'

feature 'Audition\'s Actors Show' do

  scenario 'User visits Audition path and sees all actors' do
    dana = FactoryGirl.create(:actor, email: "Something@gmail.com", name: "Dana Maginity")
    alice = FactoryGirl.create(:actor, email: "SomethingElse@gmail.com", name: "Alice Hartaag")
    audition = FactoryGirl.create(:audition)
    dana.auditions << audition
    alice.auditions << audition

    visit audition_path(audition)
    expect(page).to have_content(dana.name)
    expect(page).to have_content(alice.name)
  end
end

FactoryGirl.define do

  # post factory with a `belongs_to` association for the user
  factory :post do
    title "Through the Looking Glass"
    user
  end

  # user factory without associated posts
  factory :user do
    name "John Doe"

    # user_with_posts will create post data after the user has been created
    factory :user_with_posts do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        posts_count 5
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the user is associated properly to the post
      after(:create) do |user, evaluator|
        create_list(:post, evaluator.posts_count, user: user)
      end
    end
  end
end
