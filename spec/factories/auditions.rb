FactoryGirl.define do
  factory :audition do
    time Faker::Time.between(3.days.from_now, 7.days.from_now)
    address Faker::Address.street_address
    roles [ Faker::LordOfTheRings.character, Faker::LordOfTheRings.character, Faker::LordOfTheRings.character]
    show Faker::Book.title
    theater "The #{Faker::GameOfThrones.city} Theater"
    company "#{Faker::GameOfThrones.house} Theater Company"
    description Faker::Lorem.paragraph
    equity true

    participant
  end
end
