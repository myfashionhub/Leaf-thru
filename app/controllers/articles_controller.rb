class ArticlesController < ApplicationController

  def index
    bookmarks = Bookmark.where(reader_id: current_reader.id.to_s)
    @articles   = bookmarks.map do |bookmark|
      Article.find(bookmark.article_id)
    end
  end

  def create
    article = Article.create(article_params) 
    if article.save
      Bookmark.create(reader_id: current_reader.id, article_id: article.id) 
    else
      article = Article.find_by(url: params[:article][:url])
      if Bookmark.exists?(article_id: article.id.to_s, reader_id: current_reader.id.to_s)
        flash[:notice] = 'Already saved!'
      else          
        Bookmark.create(reader_id: current_reader.id, article_id: article.id)        
      end
    end  
    redirect_to '/feed'
  end

  def show
  end

  def destroy
    id = Bookmark.find_by(article_id: params[:id], reader_id: current_reader.id)
    Bookmark.delete(id)
    respond_to do |format|  
      format.json { render json: {} }
    end
  end

  private
  def article_params
    params.require(:article).permit(:url, :title, :publication, :shared_by, :extract, :date)
  end
end
