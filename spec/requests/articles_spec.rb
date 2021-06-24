require 'rails_helper'

RSpec.describe "Articles", type: :request do

  before do
    @article = Article.create(title: "An Article" , body: "This is an article")
  end

  describe "GET /articles" do
    it "returns http success" do
      get "/articles"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /articles/:id" do
    context "with existing article" do
      it "handles existing article" do
        get "/articles/#{@article.id}"
        expect(response).to have_http_status(:success)
      end
    end
    context "with not existing article" do
      it "handles not existing article" do
        get "/articles/xxxx"
        message = "Article not found"
        expect(flash[:alert]).to eq(message)
        expect(response).to have_http_status(302)
      end
    end


  end
end
