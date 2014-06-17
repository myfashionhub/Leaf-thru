class ArticlesController < ApplicationController

  def index
    reader_article_joins = ReaderArticleJoin.where(reader_id: current_reader.id.to_s)
    @articles   = reader_article_joins.map do |reader_article_join|
      Article.find(reader_article_join.article_id)
    end
  end

  def create
    article = Article.create(article_params) 
    if article.save
      current_reader.articles << article 
    else  
      article = Article.find_by(url: params[:url])
      if ReaderArticleJoin.exists?(article_id: article.id)
        flash[:notice] = 'Already saved!'
      else          
        current_reader.articles << article         
      end
    end  
    redirect_to '/feed'
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
    params.require(:article).permit(:url, :title, :publication, :shared_by, :extract, :date)
  end
end
