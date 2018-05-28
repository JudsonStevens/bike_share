require 'rails_helper'

describe 'Visitor' do
  context 'visits another users dashboard' do
    it "can't see another users info and is redirected to the login page" do
      user1 = User.create(first_name: 'Rogue', last_name: 'X', username: 'Rogue@gmail.com', address: '1212 X Lane')

      visit(dashboard_path(user1))

      expect(current_path).to eq(login_path)
      expect(page).to have_content('You must log in to see the dashboard')
    end
  end
end