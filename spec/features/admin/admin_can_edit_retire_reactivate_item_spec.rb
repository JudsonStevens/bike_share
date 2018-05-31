require 'rails_helper'

describe 'Admin visits admin bike-shop' do
  it 'can edit an accessory' do
    admin = User.create(first_name: 'Gertrude', last_name: 'McGillicuddy', address:'123 admin street', username:'admin', password: 'admin', role: 1)

    title = 'Jeff Goldblum'
    price = 12.00
    image = 'https://nerdist.com/wp-content/uploads/2017/05/jurassic-park-jeff-goldblum-970x545.jpg'
    description = 'Jeff Goldblum is a Stegasaurous'

    item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes')
    item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_bike_shop_path

    click_on "Edit #{item1.title}"

    expect(current_path).to eq(edit_admin_item_path(item1))

    fill_in 'item[title]', with: title
    fill_in 'item[price]', with: price
    fill_in 'item[image]', with: image
    fill_in 'item[description]', with: description
    click_on 'Update Item'

    expect(current_path).to eq(admin_bike_shop_path)
    expect(page).to have_content(title)
    expect(page).to have_content(price)
    expect(page).to have_content(description)
    within("#image-#{item1.id}") do
      expect(page).to have_css("img[src*='#{image}']")
    end
  end
end
