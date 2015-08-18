class SubscriptionsController < ApplicationController

  def index
    subscriptions = Subscription.where(reader_id: current_reader.id)
    publications = subscriptions.map do |sub|
      Publication.find(sub.publication_id)
    end
    render json: publications.to_json
  end

  def create
    Subscription.update(params, current_reader)

    render json: { msg: "You have successfully updated your subscriptions." }.to_json
  end

end
