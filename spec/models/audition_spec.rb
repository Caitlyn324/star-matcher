require 'rails_helper'

RSpec.describe Audition, type: :model do
  # it { should have_many :reviews }

  it { should have_valid(:roles).when(["LOLOLloLLolol"], ["Something", "Not Something"]) }
  it { should_not have_valid(:roles).when(nil, "", "asldfasd") }

  it { should have_valid(:theater).when("LOLOLloLLolol") }
  it { should_not have_valid(:theater).when(nil, "") }

  it { should have_valid(:address).when("LOLOLloLLolol") }
  it { should_not have_valid(:address).when(nil, "") }

  it { should have_valid(:company).when("LOLOLloLLolol") }
  it { should_not have_valid(:company).when(nil, "") }

end
