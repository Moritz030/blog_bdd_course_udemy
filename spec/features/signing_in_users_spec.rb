require "rails_helper"

RSpec.feature "SignIn Users" do

  before do
    @john = User.create!(email: "john@example.com", password: "123456")
  end

  scenario "A user signs in with valid mail and password" do
    visit "/"

    click_link "Sign in"
    
    fill_in "Email", with: @john.email
    fill_in "Password", with: @john.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
  end

  scenario "A user fails to sign in due to invalid mail and invalid password" do
    visit "/"

    click_link "Sign in"
    
    fill_in "Email", with: "john1@example.com"
    fill_in "Password", with: "1234565"
    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")
    expect(page).not_to have_link("Sign out")
  end
end