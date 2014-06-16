class ReaderArticleJoin < ActiveRecord::Base
  belongs_to :reader
  belongs_to :article
end
