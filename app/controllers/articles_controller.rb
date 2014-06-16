class ArticlesController < ApplicationController

  def index
    reader_article_joins = ReaderArticleJoin.where(reader_id: current_reader.id.to_s)
    @articles   = reader_article_joins.map do |reader_article_join|
      Article.find(reader_article_join.article_id)
    end
  end

  def create
    #unless Article.exists?(url: params[:url])
    article = Article.create(article_params) 
    current_reader.articles << article
    redirect_to articles_path
  end

  def show
  end

  def destroy
    #Delete from join table
    id = ReaderArticleJoin.find_by(article_id: params[:id].to_s)
    ReaderArticleJoin.delete(id)
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:url, :title, :publication, :extract, :date)
  end
end
