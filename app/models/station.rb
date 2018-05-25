class Station < ApplicationRecord
  has_many :trips
  validate :name, presence: true, uniqeuness: true
  validate_presence_of :dock_count, :city, :installation_date
end