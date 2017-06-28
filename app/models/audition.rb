class Audition < ApplicationRecord
  validates :roles, presence: true
  validates :theater, presence: true
  validates :address, presence: true
  validates :company, presence: true
end
