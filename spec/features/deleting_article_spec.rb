require "rails_helper"

RSpec.feature "Deleting an Article" do
  before do
    john = User.create!(email: "john@example.com", password: "123456")
    login_as(john)
    @article = Article.create(title: "Title of article", body: "Body of article", user: john)
  end
  scenario "A user deletes an Article" do
    visit "/"
    click_link @article.title

    click_link "Delete Article"
    
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Article has been deleted")
  end
end