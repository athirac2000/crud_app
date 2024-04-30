class ArticlesController < ApplicationController
  before_action :find_arti, only: [:show, :update, :destroy]
  
  def index
    articles = Article.all
    if articles.empty?
      render json: { message: "No articles found" }, status: :not_found
    else
      render json: articles
    end
  end

  def show
    if @article
      render json: @article
    else
      render json: { success: false, message: "Article Not Found" }, status: :not_found
    end
  end

  def create
    article = Article.create(arti_params)
    if article.errors.any?
      render json: { success: false, message: article.errors.full_messages }, status: :bad_request
    else
      render json: { success: true, message: "Article created" }
    end
  end

  def update
    if @article
      @article.update(arti_params)
      render json: { success: true, message: "Article updated successfully" }
    else
      render json: { success: false, message: "Article not found" }, status: :not_found
    end
  end

  def destroy
    if @article
      @article.destroy
      render json: { success: true, message: "Article deleted successfully" }
    else
      render json: { success: false, message: "Article not found" }, status: :not_found
    end
  end

  private

  def arti_params
    params.require(:article).permit(:title, :body, :author)
  end

  def find_arti
    @article = Article.find_by(id: params[:id])
  end
end
