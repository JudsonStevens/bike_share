require 'ffaker'

FactoryBot.define do
  factory :trip do
    sequence(:duration) { |n| n.to_i}
    start_date FFaker::Time.unique.date
    end_date FFaker::Time.unique.date
    start_station_id 1
    end_station_id 1
    sequence(:bike_id) { |n| n.to_i }
    subscription_type "gold"
    zip_code "12345"
  end
end
