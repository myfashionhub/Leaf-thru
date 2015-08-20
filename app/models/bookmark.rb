class Bookmark < ActiveRecord::Base
  belongs_to :readers
  belongs_to :articles

  def self.retrieve_subscription_info(readers, current_reader)
    readers.map do |reader|
      if reader.name
        reader_info = reader.name
      else
        reader_info = reader.email
      end

      subscriptions = Subscription.where(reader_id: reader.id)
      publications = subscriptions.map do |subscription|
        Publication.find(subscription.publication_id) rescue nil
      end

      bookmarks = Bookmark.where(reader_id: reader.id).to_a
      articles  = bookmarks.map do |bookmark|
        Article.find(bookmark.article_id)
      end

      shared_articles = articles.keep_if do |article|
        Bookmark.find_by(
          article_id: article.id, 
          reader_id: current_reader.id
        ) != nil
      end

      { reader_info: reader_info, 
        reader_image: reader.image, 
        publications: publications.compact, 
        shared_articles: shared_articles
      }
    end
  end   
end
