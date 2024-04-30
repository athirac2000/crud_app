class ArticlesController < ApplicationController
  def index
    articles = Article.all
    render json: articles, status: 200
  end

  def show
    article = Article.find_by(id: params[:id])
    if article
      render json: article, status: 200
    else
      render json: {
        error: "Article Not Found"
      }
    end
  end

  def create
    article = Article.new(
      arti_params
    )

    if article.save
      render json: article, status: 200
    else
      render json: {
        error: "Error Creating"
      }
    end
  end

  def update
    article = Article.find_by(id: params[:id])
    if article
      article.update(arti_params)
      render json: "Article updated successfully"
    else
      render json: {
        error: "Article Not Found"
      }
    end
  end

  def destroy
    article = Article.find_by(id: params[:id])
    if article
      article.destroy
      render json: "Article deleted successfully"
    else
      render json: {
        error: "Article Not Found"
      }
    end
  end

  private

  def arti_params
    params.require(:article).permit([
      :title,
      :body,
      :author
    ])
  end
end
