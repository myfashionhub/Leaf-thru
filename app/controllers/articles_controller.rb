require 'pocket'

class ArticlesController < ApplicationController
  def index
    bookmarks = Bookmark.where(reader_id: current_reader.id.to_s)
    @articles   = bookmarks.map do |bookmark|
      Article.find(bookmark.article_id)
    end
  end

  def create
    article = Article.find_or_create_by(article_params)
    bookmark = Bookmark.find_by(
      article_id: article.id.to_s,
      reader_id: current_reader.id.to_s
    )

    if bookmark.present?
      msg = { msg: 'Already saved!' }
    else
      pocket_id = nil
      if pocket_client.present?
        response = pocket_client.add(url: article.url)
        pocket_id = response['item']['item_id']
      end
      Bookmark.create(
        reader_id: current_reader.id,
        article_id: article.id,
        pocket_id: pocket_id
      )
      msg = { msg: 'Article bookmarked!' }
    end

    render :json => msg.to_json
  end

  def destroy
    article = Article.find(params[:id])
    bookmark = Bookmark.find_by(
      article_id: article.id,
      reader_id: current_reader.id
    )

    pocket_client.modify([
      {
        action: 'delete',
        item_id: bookmark.pocket_id
      }
    ]) if pocket_client.present?
    # Response {"action_results"=>[true], "status"=>1}
    bookmark.delete
    article.delete
    render json: { msg: 'Bookmark deleted' }.to_json
  end

  private
  def article_params
    params.require(:article).permit(
      :url, :title, :publication, :shared_by, :extract, :date
    )
  end

  def pocket_client
    if current_reader.pocket_token.present?
      Pocket::Client.new({
        consumer_key: ENV['LT_POCKET_KEY'],
        access_token: current_reader.pocket_token
      })
    else
      nil
    end
  end
end
