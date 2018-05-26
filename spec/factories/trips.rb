require 'ffaker'

FactoryBot.define do
  factory :trip do
    sequence(:duration) { |n| "Duration: #{n}" }
    sequence(:start_date) { |n| "Start Date: #{n}" }
    sequence(:end_date) { |n| "End Date: #{n}" }
    sequence(:end_station_id) { |n| "End Station ID: #{n}" }
    sequence(:start_station_id) { |n| "Start Station ID: #{n}" }
    sequence(:bike_id) { |n| "Bike ID: #{n}" }
    sequence(:subscription_type) { |n| "Subscription Type: #{n}" }
    sequence(:zip_code) { |n| "Zip Code: #{n}" }
  end
end
