require 'rails_helper'

describe 'Visitor goes to retired accessory show page' do
  it 'visitor can see retired accessory show page' do
    item = Item.create(title:'Bell', price: 1.50, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Wow, so great!', is_retired?: true )

    visit item_path(item)

    expect(page).to have_content(item.title)
    expect(page).to have_content(item.price)
    expect(page).to have_content(item.description)
  end

  it 'visitor can see retired banner instead of add to cart' do
    retired = 'Accesory Retired'
    item = Item.create(title:'Bell', price: 1.50, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Wow, so great!', is_retired?: true )

    visit item_path(item)

    expect(page).to have_content(retired)
  end

  it 'visitor cannot see add to cart' do
    add_to_cart = 'Add to Cart'
    item = Item.create(title:'Bell', price: 1.50, image: 'http://i0.kym-cdn.com/entries/icons/original/000/003/980/hold-all-these-limes.jpg', description: 'Wow, so great!', is_retired?: true )

    visit item_path(item)

    expect(page).to_not have_content(add_to_cart)
  end
end
