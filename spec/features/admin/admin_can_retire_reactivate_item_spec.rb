require 'rails_helper'

describe 'Admin visits admin bike-shop' do
  it 'can retire an item' do
      admin = User.create(first_name: 'Gertrude', last_name: 'McGillicuddy', address:'123 admin street', username:'admin', password: 'admin', role: 1)

      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes', is_retired?: false)
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice', is_retired?: false)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_bike_shop_path

      click_on "Retire #{item1.title}"

      expect(page).to have_content("You have retired #{item1.title}")

      click_on "Reactivate #{item1.title}"

      expect(page).to have_content("You have reactivated #{item1.title}")
  end
end
