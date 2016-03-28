class ArticlesController < ApplicationController

  def index
    bookmarks = Bookmark.where(reader_id: current_reader.id.to_s)
    @articles   = bookmarks.map do |bookmark|
      Article.find(bookmark.article_id)
    end
  end

  def create
    article = Article.find_or_create_by(article_params)
    
    if Bookmark.exists?(article_id: article.id.to_s, reader_id: current_reader.id.to_s)
      msg = { msg: 'Already saved!' }
    else  
      Bookmark.create(reader_id: current_reader.id, article_id: article.id)
      msg = { msg: 'Article bookmarked!' }
    end

    render :json => msg.to_json
  end

  def show
  end

  def destroy
    id = Bookmark.find_by(article_id: params[:id], reader_id: current_reader.id)
    Bookmark.delete(id)
    render json: { msg: 'Bookmark deleted' }.to_json
  end

  private
  def article_params
    params.require(:article).permit(
      :url, :title, :publication, :shared_by, :extract, :date
    )
  end
end
