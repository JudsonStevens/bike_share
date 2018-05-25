class Trip < ApplicationRecord
  belongs_to :end_station, :class => "Station", foreign_key: :end_station
  belongs_to :start_station, :class => "Station", foreign_key: :end_station
  validates_presence_of :duration, :start_date, :end_date, :start_station_id, :end_station_id, :subscription_type, :zip_code
  validates :bike_id, presence: true, uniqueness: true
end