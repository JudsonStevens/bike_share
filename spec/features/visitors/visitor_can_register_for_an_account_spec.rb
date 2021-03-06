require 'rails_helper'

describe 'Visitor' do
  context 'clicks on login link on the navbar' do
    it 'can then click on create an account, fill out the form, and create a new account, landing at the profile page' do
      first_name = 'Jo'
      last_name = 'Smith'
      username = 'Jo@gmail.com'
      address = '1223 Oakview Drive, CO'
      password = 'longpassword111'

      visit(root_path)

      click_on('Log In')
      click_on('Click here to create an account')
      fill_in('user[username]', with: username)
      fill_in('user[first_name]', with: first_name)
      fill_in('user[last_name]', with: last_name)
      fill_in('user[address]', with: address)
      fill_in('user[password]', with: password)
      fill_in('user[password_confirmation]', with: password)

      click_on('Create User')

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content(first_name)
      expect(page).to have_content(last_name)
      expect(page).to have_content(username)
      expect(page).to have_content(address)
      expect(page).to_not have_content('Log In')
      expect(page).to have_content('Log Out')
    end
  end
end
