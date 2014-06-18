class SubscriptionsController < ApplicationController

  def create
    Subscription.destroy_all(:reader_id => current_reader.id)
    #clear out all subscribers to keep from keeping feeds readers don't want
    pub_ids = params[:reader][:publication_ids]
    pub_ids.each do |pub_id|
      if pub_id != "" #filter out empty string values. Better than this would be find out why I'm getting an empty string at end of each params
        Subscription.create({
         reader_id: current_reader.id,
         publication_id: pub_id
        })
      end
    end
    redirect_to profile_path
    flash[:notice] = "You have successfully updated your subscriptions."
  end

end
