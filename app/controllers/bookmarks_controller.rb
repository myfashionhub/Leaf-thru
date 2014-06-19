class BookmarksController < ApplicationController
  def index
    readers = Reader.all.to_a
    readers.keep_if { |reader| reader.id != current_reader.id }
    @leafers = readers.map do |reader|
      if reader.name
        reader_info = reader.name
      else
        reader_info = reader.email
      end
      if reader.image
        reader_image = reader.image
      else
        reader_image = "assets/profile.svg"
      end
      subscriptions = Subscription.where(reader_id: reader.id)
      publications = subscriptions.map do |subscription|
        Publication.find(subscription.publication_id)
      end
      bookmarks = Bookmark.where(reader_id: reader.id).to_a
      articles  = bookmarks.map do |bookmark|
        Article.find(bookmark.article_id)
      end

      shared_articles = articles.keep_if do |article|
        Bookmark.find_by(article_id: article.id, reader_id: current_reader.id) != nil
      end

      {reader_info: reader_info, reader_image: reader_image, publications: publications, shared_articles: shared_articles}
    end
  end
end
