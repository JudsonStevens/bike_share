require 'rails_helper'

describe 'User' do
  context 'who is logged in' do
    it 'can checkout items in its cart, be taken to dash board and see the flash message including the total' do
      user1 = User.create(first_name: 'Professor', last_name: 'Xavier', address: '111 X Academy Lane', password: 'secret11', username: 'PX@xmen.org')
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
      item3 = Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
      item4 = Item.create(price: 8.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')

      page.set_rack_session(shopping_cart: { item1.id => 2, item2.id => 5, item3.id => 10 } )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit(cart_path)

      click_on('Check Out')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Successfully submitted your order totaling $250.00")
    end

    it 'sees an empty shopping cart after checkout' do
      empty = 'Shopping Cart - Empty'
      user1 = User.create(first_name: 'Professor', last_name: 'Xavier', address: '111 X Academy Lane', password: 'secret11', username: 'PX@xmen.org')
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')

      page.set_rack_session(shopping_cart: { item1.id => 2})

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit(cart_path)

      click_on('Check Out')
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Empty")
    end

    it 'can checkout items and see the new order on its dashboard' do
      user1 = User.create(first_name: 'Professor', last_name: 'Xavier', address: '111 X Academy Lane', password: 'secret11', username: 'PX@xmen.org')
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
      item3 = Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
      item4 = Item.create(price: 8.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')

      page.set_rack_session(shopping_cart: { item1.id => 2, item2.id => 5, item3.id => 10 } )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit(cart_path)

      click_on('Check Out')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_link("Order ID: #{Order.last.id}")
    end

    it 'can checkout items, click on the new order in their dashboard, and see details about that order' do
      user1 = User.create(first_name: 'Professor', last_name: 'Xavier', address: '111 X Academy Lane', password: 'secret11', username: 'PX@xmen.org')
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
      item3 = Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
      item4 = Item.create(price: 8.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')
      order1 = user1.orders.create(status: "canceled")

      page.set_rack_session(shopping_cart: { item1.id => 2, item2.id => 5, item3.id => 10 } )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit(cart_path)

      click_on('Check Out')
      order = Order.last
      click_on("Order ID: #{order.id}")

      expect(current_path).to eq(order_path(order))
      expect(page).to have_content(item1.title)
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item3.title)
      expect(page).to have_content("Order ID: #{order.id}")
      expect(page).to have_content('Order Total: $ 250.00')
      expect(page).to have_content("Order Status: #{order.status}")
      expect(page).to have_content("Order Submitted: #{order.created_at.strftime("%A, %m/%d/%Y")}")
    end

    it 'can checkout items, click on the new order in their dashboard, and see details about that canceled order' do
      user1 = User.create(first_name: 'Professor', last_name: 'Xavier', address: '111 X Academy Lane', password: 'secret11', username: 'PX@xmen.org')
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
      item3 = Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
      item4 = Item.create(price: 8.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')
      order1 = user1.orders.create(status: "cancelled")

      page.set_rack_session(shopping_cart: { item1.id => 2, item2.id => 5, item3.id => 10 } )

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit(dashboard_path)

      click_on("Order ID: #{order1.id}")

      expect(page).to have_content("Order was cancelled on #{order1.updated_at.strftime("%A, %m/%d/%Y")}")
    end
  end
end
