require 'rails_helper'

describe Trip, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :duration }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :start_station_id }
    it { should validate_presence_of :end_station_id }
    it { should validate_presence_of :subscription_type }
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :bike_id }
  end

  describe 'Relationships' do
    it { should belong_to(:station) }
    # it { should belong_to(:start_station) }
  end
end