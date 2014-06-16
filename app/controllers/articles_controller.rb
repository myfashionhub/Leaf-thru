class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    article = Article.create(article_params)
    current_reader.articles << article
    # pop up announcement
  end

  def show
  end

  def destroy
    Article.delete(params[:id])
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:url, :title, :publication, :extract, :date)
  end
end
