class PublicationsController < ApplicationController

  def index
    publications = Publication.all
    categories = publications.map do |pub|
      pub.topic
    end
    categories.uniq!
    classified = []
    categories.each do |cat|
      classified.push({ cat: cat, pubs: Publication.where(topic: cat) })
    end
    render json: classified.to_json
  end

end
