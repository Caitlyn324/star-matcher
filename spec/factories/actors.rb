FactoryGirl.define do
  factory :actor do
    name Faker::HarryPotter.character
    email Faker::Internet.free_email
    password "password"
    phone_number "2127445675"

    participant
    after(:create)  { |u| u.confirm }
    after(:build)   { |u| u.skip_confirmation_notification! }
  end
end
