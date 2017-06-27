class Audition < ApplicationRecord
  validate :roles, presence: true
  validate :theater, presence: true
  validate :address, presence: true
  validate :company, presence: true
end
