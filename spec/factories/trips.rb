require 'ffaker'

FactoryBot.define do
  factory :trip do
    sequence(:duration) { |n| n.to_i}
    start_date FFaker::Time.unique.date
    end_date FFaker::Time.unique.date
    sequence(:end_station_id) { |n| "End Station ID: #{n}" }
    sequence(:start_station_id) { |n| "Start Station ID: #{n}" }
    sequence(:bike_id) { |n| "Bike ID: #{n}" }
    sequence(:subscription_type) { |n| "Subscription Type: #{n}" }
    sequence(:zip_code) { |n| "Zip Code: #{n}" }
  end
end
