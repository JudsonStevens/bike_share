require 'rails_helper'

describe 'Admin visits admin dashboard' do
  it 'can link to item show page from dashboard' do
    admin = User.create(first_name: 'Gertrude', last_name: 'McGillicuddy', address:'123 admin street', username:'admin', password: 'admin', role: 1)

    item1 = Item.create(price: 15.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes', title: 'Bike Limes', is_retired?: false)
    item2 = Item.create(price: 22.00, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Too many limes x2', title: 'Bike Limes Twice', is_retired?: false)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_bike_shop_path

    click_on "#{item1.title}"

    expect(current_path).to eq(item_path(item1))
  end
end
