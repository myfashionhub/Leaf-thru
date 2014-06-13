require 'open-uri'

class Article < ActiveRecord::Base

  doc.css("h1 [class='title']").children.text

end
