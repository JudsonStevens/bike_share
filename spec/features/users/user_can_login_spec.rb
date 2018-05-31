require 'rails_helper'

describe 'User' do
  context 'user visits the login path' do
    it 'fills in their login info and clicks log in, then sees their dashboard and the login changes to logout' do
      user1 = User.create(first_name: 'Charles', last_name: 'Xavier', username: 'Charles@gmail.com', password: '123', address: '1212 College Lane')

      visit(login_path)

      fill_in('session[email]', with: user1.username)
      fill_in('session[password]', with: user1.password)

      within('form') do
        click_on('Log In')
      end

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(user1.first_name)
      expect(page).to have_content(user1.last_name)
      expect(page).to have_content(user1.address)
      expect(page).to have_content("Logged in as #{user1.username}")
    end
  end
end
