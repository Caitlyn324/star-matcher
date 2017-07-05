class Audition < ApplicationRecord
  has_many :participants
  has_many :actors, through: :participants

  validates :roles, presence: true
  validates :company, presence: true
end
