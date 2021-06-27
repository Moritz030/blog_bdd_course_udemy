require "rails_helper"

RSpec.feature "SignUp Users" do
  scenario "A user signs up with valid credentials" do
    visit "/"
    click_link "Sign up"

    fill_in "Email",	with: "user@example.com"
    fill_in "Password", with: "123456"
    fill_in "Password confirmation", with: "123456"
    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully")
    
  end

  scenario "A user fails to sign up due to invalid credentials" do
    visit "/"
    click_link "Sign up"

    fill_in "Email",	with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"

    expect(page).to have_content("prohibited this user from being saved")
    
  end
end