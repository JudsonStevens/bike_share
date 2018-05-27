require 'rails_helper'

describe 'Visitor' do
  context 'can go to cart path' do
    it 'and can see all items in their cart' do
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
      item3 = Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
      item4 = Item.create(price: 8.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')

      page.set_rack_session(temporary_shopping_cart: { item1.id => 2, item2.id => 5, item3.id => 10 } )
      visit(cart_path)

      expect(page).to have_content(item1.title)
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item3.title)
      expect(page).to_not have_content(item4.title)

      expect(page).to have_content(item1.price)
      expect(page).to have_content(item2.price)
      expect(page).to have_content(item3.price)

      expect(page).to have_content('Quantity - 2')
      expect(page).to have_content('Quantity - 10')
      expect(page).to have_content('Quantity - 5')

      expect(page).to have_content('Shopping Cart - 17')

      expect(page).to have_content('Subtotal - $ 30.00')
      expect(page).to have_content('Subtotal - $ 110.00')
    end
  end

  context 'can log in after viewing their cart' do
    it 'and will have the same items in the cart' do
      user1 = User.create(first_name: 'Professor', last_name: 'Xavier', address: '111 X Academy Lane', password: 'secret11', username: 'PX@xmen.org')
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
      item3 = Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
      item4 = Item.create(price: 8.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')

      page.set_rack_session(temporary_shopping_cart: { item1.id => 2, item2.id => 5, item3.id => 10 } )
      visit(cart_path)

      click_on('Log In')

      fill_in('session[email]', with: user1.username)
      fill_in('session[password]', with: user1.password)

      within('form') do
        click_on('Log In')
      end

      visit(cart_path)

      expect(page).to have_content(item1.title)
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item3.title)
      expect(page).to_not have_content(item4.title)

      expect(page).to have_content(item1.price)
      expect(page).to have_content(item2.price)
      expect(page).to have_content(item3.price)

      expect(page).to have_content('Quantity - 2')
      expect(page).to have_content('Quantity - 10')
      expect(page).to have_content('Quantity - 5')

      expect(page).to have_content('Shopping Cart - 17')

      expect(page).to have_content('Subtotal - $ 30.00')
      expect(page).to have_content('Subtotal - $ 110.00')
    end
  end
end
