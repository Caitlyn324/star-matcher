FactoryGirl.define do
  factory :audition do
    time Faker::Time.between(3.days.from_now, 7.days.from_now)
    address Faker::Address.street_address
    roles ["Hanibal", "Not Hanibal"]
    show "Hanibal"
    theater "The Walnut Street Theater"
  end
end
