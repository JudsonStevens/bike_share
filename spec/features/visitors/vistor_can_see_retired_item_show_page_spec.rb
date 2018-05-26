require 'rails_helper'

describe 'Visitor goes to retired accessory show page' do
  it 'visitor can see retired accessory show page' do
    item = Item.create(title:'Bell', price: 1.50, image: 'example.com/image', description: 'Wow, so great!', is_retired?: true )

    visit item_path(item)
    save_and_open_page

    expect(page).to have_content(item.title)
    expect(page).to have_content(item.price)
    expect(page).to have_content(item.description)
  end
end
