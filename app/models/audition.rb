class Audition < ApplicationRecord
  has_many :roles
  has_many :participants
  has_many :actors, through: :participants

  validates :company, presence: true
end
