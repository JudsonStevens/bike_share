require 'rails_helper'

describe 'Admin' do
  context 'who is logged in' do
    it 'visits an order page and can see the purchaser name and address along with order info' do
      admin = User.create(first_name: 'Gertrude', last_name: 'McGillicuddy', address:'123 admin street', username:'admin', password: 'admin', role: 1)
      order = admin.orders.create(status: 'shipped')
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes', is_retired?: false)
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice', is_retired?: false)
      ItemOrder.create(item_id: item1.id, order_id: order.id, quantity: 1)
      ItemOrder.create(item_id: item2.id, order_id: order.id, quantity: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit(order_path(order))

      expect(page).to have_content(admin.first_name)
      expect(page).to have_content(admin.last_name)
      expect(page).to have_content(admin.address)
      expect(page).to have_content(order.status)
      expect(page).to have_content(order.created_at.strftime("%A, %m/%d/%Y"))
      expect(page).to have_content(item1.price)
      expect(page).to have_content(item2.price)
      expect(page).to have_content(item1.title)
      expect(page).to have_content(item2.title)
      expect(page).to have_content("Order Total: $ #{item1.price + item2.price}")
    end
  end
end
