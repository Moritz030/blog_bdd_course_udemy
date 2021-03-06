class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  def index
    @articles = Article.all
  end
  def new
    @article = Article.new
  end
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article hast not been created"
      render :new
    end
  end
  def show
  end
  def edit
    unless @article.user == current_user
      # raise
      flash[:alert] = "You are not owner of this article."
      redirect_to root_path
    end
  end
  def update
    # raise
    unless @article.user == current_user
      flash[:alert] = "You are not owner of this article."
      redirect_to root_path
    else
      if @article.update(article_params)
        flash[:success] = "Article has been updated"
        redirect_to article_path(@article)
      else
        flash.now[:danger] = "Article has not been updated"
        render :edit
      end
    end
  end
  def destroy
    if @article.destroy
      flash[:success] = "Article has been deleted"
      redirect_to articles_path
    else

    end
  end

  protected
  def resource_not_found
    message = "Article not found"
    flash[:alert] = message
    redirect_to root_path
  end
  private
  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
