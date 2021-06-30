require 'rails_helper'

RSpec.describe "Articles", type: :request do

  before do
    @john = User.create(email: "john@example.com", password: "123456")
    @james = User.create(email: "james@example.com", password: "123456")
    @article = Article.create!(title: "An Article" , body: "This is an article", user: @john)
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
        # puts @article.id
        get "/articles/#{@article.id}"
        expect(response).to have_http_status(:success)
      end
    end
    context "with not existing article" do
      it "handles not existing article" do
        get "/articles/xxxx"
        # puts @request.host
        # puts response.headers
        message = "Article not found"
        expect(flash[:alert]).to eq(message)
        expect(response).to have_http_status(302)
      end
    end

    describe "Get /articles/:id/edit" do
      context "with NOT signed in user" do
        before { get "/articles/#{@article.id}/edit" }

        it "redirects to sign in page" do
          expect(response.status).to eq 302
          message = "You need to sign in or sign up before continuing."
          expect(flash[:alert]).to eq(message)
        end
      end
      context "with signed in user who is owner" do
        before do
          login_as(@john)
          get "/articles/#{@article.id}/edit"
        end
        it "successfully requests edit page" do
          expect(response.status).to eq 200
        end
      end

      context "with signed in user who is NOT owner" do
        before do
          login_as(@james)
          get "/articles/#{@article.id}/edit"
        end
        it "redirects to the home page" do
          expect(response.status).to eq 302
          message = "You are not owner of this article."
          expect(flash[:alert]).to eq(message)
        end
      end
    end

  end
end
