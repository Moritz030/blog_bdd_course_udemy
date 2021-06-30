require "rails_helper"

RSpec.feature "Listing Articles" do
  before do
    @john = User.create!(email: "john@example.com", password: "123456")
    james = User.create!(email: "james@example.com", password: "123456")
    @article1 = Article.create(title: "The first article" , body: "Body of first article", user: @john)
    @article2 = Article.create(title: "The second article", body: "Body of second article", user: james)
  end

  scenario "A user lists all articles with articles created and user is not signed in" do
    visit "/"
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_content("Created by: #{@article1.user.email}")
    expect(page).to have_content("Created by: #{@article2.user.email}")
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).not_to have_link("New Article")
  end

  scenario "A user lists all articles with articles created and user is signed in" do
    login_as(@john)
    visit "/"
    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_content("Created by: #{@article1.user.email}")
    expect(page).to have_content("Created by: #{@article2.user.email}")
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
    expect(page).to have_link("New Article")
  end

  scenario "A user has no articles" do
    Article.destroy_all
    visit "/"

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_content("Created by: #{@article1.user.email}")
    expect(page).not_to have_content("Created by: #{@article2.user.email}")
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)
  
    within("h1#no-articles") do
      expect(page).to have_content("No Articles Created")
    end
  end
end