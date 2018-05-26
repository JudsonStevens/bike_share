require 'rails_helper'

describe Item, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :description }
  end

  describe 'Relationships' do
    it { should have_many(:item_orders) }
    it { should have_many(:orders).through(:item_orders) }
  end
end
