class BookmarksController < ApplicationController
  
  def index
    readers = Reader.all.to_a
    readers.keep_if { |reader| reader.id != current_reader.id }
    @leafers = Bookmark.retrieve_subscription_info(readers, current_reader)
  end

end
