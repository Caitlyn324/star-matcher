class Participant < ApplicationRecord
  belongs_to :audition
  belongs_to :actor
end
