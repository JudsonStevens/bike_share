require 'rails_helper'

describe 'visitor visits bike shop page' do
  xit 'sees 12 bike accessories' do
    accessories = create_list(:item, 12)

    visit '/bike-shop'

    expect(page).to have_content(accessories[11])
  end
end
