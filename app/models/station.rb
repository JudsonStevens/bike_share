class Station < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  has_many :start_stations, class_name: "Trip", foreign_key: "start_station_id"
  has_many :end_stations, class_name: "Trip", foreign_key: "end_station_id"
  validates :name, presence: true, uniqueness: true
  validates_presence_of :dock_count, :city, :installation_date

  def sum_starting_trips
    start_stations.length
  end

  def sum_ending_trips
    end_stations.length
  end

  # Ask about returning an object from the query.
  def frequent_destination_station
    start_stations.group(:end_station_id).order("count(end_station_id) DESC").count.first
  end

  def frequent_origination_station
    end_stations.group(:start_station_id).order("count(start_station_id) DESC").count.first
  end

  def date_with_most_trip_starts
    start_stations.group(:start_date).order("count(start_date) DESC").count.first[0]
  end

  def most_freq_zip_codes
    start_stations.group(:zip_code).order("count(zip_code) DESC").count.first[0]
  end

  def most_freq_bike_id
    start_stations.group(:bike_id).order("count(bike_id) DESC").count.first[0]
  end
end
