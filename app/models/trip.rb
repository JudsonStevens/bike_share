class Trip < ApplicationRecord
  max_paginates_per 30
  belongs_to :end_station, class_name: "Station", foreign_key: "end_station_id"
  belongs_to :start_station, class_name: "Station", foreign_key: "start_station_id"
  validates_presence_of :duration, :start_date, :end_date, :start_station_id, :end_station_id, :subscription_type
  validates :bike_id, presence: true

  def self.average_ride_duration
    average(:duration)
  end

  def self.longest_ride
    maximum(:duration)
  end

  def self.shortest_ride
    minimum(:duration)
  end

  def self.most_starting_station
    Station.joins(:start_stations).select('stations.id,
                                           stations.name,
                                           COUNT(trips.start_station_id) AS start_station_count')
                                  .group('stations.id')
                                  .order('start_station_count DESC')
                                  .first
  end

  def self.most_end_station
    Station.joins(:end_stations).select('stations.id,
                                           stations.name,
                                           COUNT(trips.end_station_id) AS end_station_count')
                                  .group('stations.id')
                                  .order('end_station_count DESC')
                                  .first
  end

  def self.month_breakdown
    group("date_trunc('month', start_date)").order('count_all DESC').count
  end

  def self.year_breakdown
    group("date_trunc('year', start_date)").order('count_all DESC').count
  end

  def self.most_ridden_bike
    group(:bike_id).order('count_all DESC').count.first
  end

  def self.least_ridden_bike
    group(:bike_id).order('count_all ASC').count.first
  end

  def self.subscription_count
    group(:subscription_type).order('count_all DESC').count
  end

  def self.date_with_most_trips
    group(:start_date).order('count_all DESC').count.first
  end

  def self.date_with_least_trips
    group(:start_date).order('count_all ASC').count.first
  end
end
