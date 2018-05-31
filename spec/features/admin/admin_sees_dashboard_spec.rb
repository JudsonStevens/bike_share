require 'rails_helper'

describe 'Admin' do
  context 'who is logged in' do
    it 'should have a link for viewing all accessories' do
      admin = User.create(first_name: 'Gertrude', last_name: 'McGillicuddy', address:'123 admin street', username:'admin', password: 'admin', role: 1)
      item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes', is_retired?: false)
      item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice', is_retired?: false)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path(admin)

      expect(page).to have_link('View all Accessories')
      click_on 'View all Accessories'
      expect(current_path).to eq("/admin/bike-shop")

      expect(page).to have_content(item1.price)
      expect(page).to have_content(item1.description)
      expect(page).to have_content(item1.title)

      within("#image-#{item1.id}") do
        expect(page).to have_css("img[src*='#{item1.image}']")
      end

      expect(page).to have_content(item2.price)
      expect(page).to have_content(item2.description)
      expect(page).to have_content(item2.title)

      within("#image-#{item2.id}") do
        expect(page).to have_css("img[src*='#{item2.image}']")
      end

      expect(page).to have_button("Edit #{item1.title}")
      expect(page).to have_button("Edit #{item2.title}")
      expect(page).to have_button("Retire #{item1.title}")
      expect(page).to have_button("Retire #{item2.title}")
    end
    it 'should display all orders with order information' do
      admin = User.create(first_name: 'Albert', last_name: 'Hoffman', address:'123 admin street', username:'admin', password: 'admin', role: 1)
      order_1 = admin.orders.create(status: 'ordered')
      order_2 = admin.orders.create(status: 'completed')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path(admin)


      expect(page).to have_content("Orders:")
      save_and_open_page
      expect(page).to have_content("#{order_1.status}")
      expect(page).to have_content("#{order_2.status}")
    end
  end
end
