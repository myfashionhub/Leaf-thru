class SubscriptionsController < ApplicationController

  def index
    subscriptions = Subscription.where(reader_id: current_reader.id)
    publications = subscriptions.map do |sub|
      Publication.find(sub.publication_id)
    end
    render json: publications.to_json
  end

  def create
    Subscription.destroy_all(:reader_id => current_reader.id)
    #clear out all subs to prevent keeping feeds readers don't want
    pub_ids = params[:pub_ids]
    pub_ids.each do |pub_id|
      Subscription.create({
       reader_id: current_reader.id,
       publication_id: pub_id
      })
    end
    render json: { msg: "You have successfully updated your subscriptions." }.to_json
  end

end
