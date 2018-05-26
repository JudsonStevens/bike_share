require 'rails_helper'

describe Station, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :dock_count }
    it { should validate_presence_of :city }
    it { should validate_presence_of :installation_date }
  end

  describe 'Relationships' do
    it { should have_many(:trips) }
  end
end