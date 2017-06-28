FactoryGirl.define do
  factory :user do
    name "Joe Tabas"
    email "mofo@gmail.com"
    password "password"
    phone_number "2127445675"

    after(:build)   { |u| u.skip_confirmation_notification! }
    after(:create)  { |u| u.confirm }
  end
end
