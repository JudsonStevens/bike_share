require 'rails_helper'

describe 'Admin' do
  context 'who is logged in' do
    it 'should have a link for viewing all accessories' do
      admin = User.create(first_name: 'Gertrude', last_name: 'McGillicuddy', address:'123 admin street', username:'admin', password: 'admin', role: 1)
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path(admin)

      expect(page).to have_link('View all Accessories')
      click_on 'View all Accessories'
      expect(current_path).to eq("/admin/bike-shop")

      expect(page).to have_content(item1.price)
      expect(page).to have_content(item1.description)
      expect(page).to have_content(item1.title)
      expect(page).to have_content(item1.image)
      expect(page).to have_content(item2.price)
      expect(page).to have_content(item2.description)
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item2.image)
      expect(page).to have_link("Edit #{item1.title}")
      expect(page).to have_link("Edit #{item2.title}")
      expect(page).to have_link("Retire #{item1.title}")
      expect(page).to have_link("Retire #{item2.title}")
    end
  end
end
