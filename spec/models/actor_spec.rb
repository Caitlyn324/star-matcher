require 'rails_helper'

RSpec.describe Actor, type: :model do
  it { should have_valid(:name).when("Joe Tabas") }
  it { should_not have_valid(:name).when(nil, "", "asldfasd") }

  it { should have_valid(:email).when("LOLOLloLLolol@gmail.com") }
  it { should_not have_valid(:email).when(nil, "", "@gmail.com", "chris.donohue", "Chris.donohue@gmail") }

  it { should have_valid(:password).when("LOLOLloLLolol") }
  it { should_not have_valid(:password).when(nil, "", "0345") }

  it { should have_valid(:phone_number).when("1234567890", "(267)987-1412") }
  it { should_not have_valid(:phone_number).when(nil, "", "123345") }
end
