require 'rails_helper'

describe 'Visitor' do
  context 'can go to cart path' do
    it 'and can see all items in their cart' do
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
      item3 = Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
      item4 = Item.create(price: 8.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')

      page.set_rack_session(shopping_cart: { item1.id => 2, item2.id => 5, item3.id => 10 } )
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

    it 'can remove an item from the cart, see a flash message with a link to the item show page, and should be shown the cart without the item' do
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
      item3 = Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
      item4 = Item.create(price: 8.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')

      page.set_rack_session(shopping_cart: { item1.id => 2, item2.id => 5, item3.id => 1 } )
      visit(cart_path)
      within(all('form').last) do
        click_on('Remove Item From Cart')
      end
      expect(page).to have_content("You have removed #{item3.title} from your cart!")
      expect(page).to have_link("#{item3.title}")
      expect(page).to_not have_content(('%.2f' % item3.price))
      expect(page).to_not have_content(item3.description)
    end

    it 'can increase the quantity of an item and it should reflect in the cart' do
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')

      page.set_rack_session(shopping_cart: { item1.id => 2} )

      visit(cart_path)
      click_on('Increase Quantity')

      expect(page).to have_content('Quantity - 3')
    end

    it 'can decrease the quantity of an item and it should reflect in the cart' do
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')

      page.set_rack_session(shopping_cart: { item1.id => 2} )

      visit(cart_path)

      click_on('Decrease Quantity')

      expect(page).to have_content('Quantity - 1')
    end

    it 'cannot descrease the quantity of an item if it is 1' do
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')

      decrease = 'Decrease Quantity'

      page.set_rack_session(shopping_cart: { item1.id => 1} )

      visit(cart_path)

      expect(page).to_not have_content(decrease)
    end

    it 'can click on checkout and be taken to the login page' do
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
      item3 = Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
      item4 = Item.create(price: 8.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')

      page.set_rack_session(shopping_cart: { item1.id => 2, item2.id => 5, item3.id => 5 } )
      visit(cart_path)

      click_on('Check Out')

      expect(current_path).to eq(login_path)
    end
  end

  context 'can log in after viewing their cart' do
    it 'and will have the same items in the cart' do
      user1 = User.create(first_name: 'Professor', last_name: 'Xavier', address: '111 X Academy Lane', password: 'secret11', username: 'PX@xmen.org')
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
      item3 = Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
      item4 = Item.create(price: 8.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')

      page.set_rack_session(shopping_cart: { item1.id => 2, item2.id => 5, item3.id => 10 } )
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
