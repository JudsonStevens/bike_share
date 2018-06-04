require 'rails_helper'

describe 'Visitor' do
  context 'can go to the item index' do
    it 'and see all items with image, title, description, and price' do
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
      item3 = Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
      item4 = Item.create(price: 8.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')

      visit(bike_shop_path)

      expect(page).to have_content(item1.description)
      expect(page).to have_content(item2.description)
      expect(page).to have_content(item3.description)
      expect(page).to have_content(item4.description)

      expect(page).to have_content(item1.price)
      expect(page).to have_content(item2.price)
      expect(page).to have_content(item3.price)
      expect(page).to have_content(item4.price)

      expect(page).to have_content(item1.title)
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item3.title)
      expect(page).to have_content(item4.title)

      expect(page).to have_css("img[src*='http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg']")
      expect(page).to have_css("img[src*='http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg']")
      expect(page).to have_css("img[src*='http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg']")
      expect(page).to have_css("img[src*='http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg']")
    end

    it 'and click on add to cart for an item, see a flash message, and see the cart count updated' do
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')
      item3 = Item.create(price: 11.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x3', title: 'Bike Limes Thrice')
      item4 = Item.create(price: 8.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x4', title: 'Bike Limes Quad')

      visit(bike_shop_path)
      first('form').click_button('Add to Cart', match: :first)

      expect(page).to have_content("You have added #{item1.title} to your cart!")
      expect(page).to have_content('Shopping Cart - 1')
    end

    it 'sees Item retired instead of add to cart' do
        item = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes', is_retired?: true)
        retired = 'Item Retired'

        visit(bike_shop_path)

        expect(page).to have_content(retired)

    end
  end
end
