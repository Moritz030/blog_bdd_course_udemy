require "rails_helper"

RSpec.feature "Show Article" do

  before do
    john = User.create!(email: "john@example.com", password: "123456")
    @article = Article.create(title: "An article", body: "This is an article", user: john)
  end
  scenario "A user shows an article" do
    user_shows_an_article
  end

  scenario "A user shows an article and goes back to index page by clicking on back" do
    user_shows_an_article
    click_link "Back"
    expect(page.current_path).to eq(articles_path)
  end
end

private

def user_shows_an_article
  visit "/"
  click_link @article.title
  expect(page.current_path).to eq(article_path(@article))
  expect(page).to have_content(@article.title)
  expect(page).to have_content(@article.body)
  expect(page).to have_content("Created by: #{@article.user.email}")
  expect(page).to have_link("Back")
  
end