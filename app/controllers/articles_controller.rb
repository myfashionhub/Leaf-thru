class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
  end

  def create
    @article = Article.create(article_params)
  end

  def show
  end

  private
  def article_params
    params.require(:article).permit(:url, :headline, :publication, :extract, :date)
  end
end
