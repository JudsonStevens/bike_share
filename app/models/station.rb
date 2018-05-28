class Station < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  has_many :start_stations, class_name: "Trip", foreign_key: "start_station_id"
  has_many :end_stations, class_name: "Trip", foreign_key: "end_station_id"
  validates :name, presence: true, uniqueness: true
  validates_presence_of :dock_count, :city, :installation_date
end