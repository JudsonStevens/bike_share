require 'rails_helper'

describe Order, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :status }
  end

  describe 'Relationships' do
    it { should belong_to(:user) }
    it { should have_many(:item_orders) }
    it { should have_many(:items).through(:item_orders) }
  end

  describe 'Class methods' do
    describe '.status_count' do
      it 'should count the amount of orders with matching status' do
        user1 = User.create(first_name: 'Charles', last_name: 'Xavier', username: 'Charles@gmail.com', password: '123', address: '1212 College Lane')
        order_1 = user1.orders.create!(status: 'completed')
        order_2 = user1.orders.create!(status: 'completed')
        order_3 = user1.orders.create!(status: 'cancelled')
        order_4 = user1.orders.create!(status: 'cancelled')
      
        expect(Order.status_count('completed')).to eq 2
        expect(Order.status_count('cancelled')).to eq 2
      end
    end
  end
end
