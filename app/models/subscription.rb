class Subscription < ActiveRecord::Base
  belongs_to :reader
  belongs_to :publication

  def self.update(params, reader)
    if params[:pub_ids]
      new_pubs = params[:pub_ids].uniq
      subscriptions = Subscription.where(reader_id: reader.id)
      
      current_pubs = subscriptions.map do |sub|
        sub.publication_id
      end

      new_pubs.each do |pub_id|
        if current_pubs.include?(pub_id)
          current_pubs.delete(pub_id)
        else  
          Subscription.create({
           reader_id: reader.id,
           publication_id: pub_id
          })
        end
      end

      current_pubs.each do |pub_id|
        Subscription.find_by(
          reader_id: reader.id,
          publication_id: pub_id
        ).delete
      end
    else
      Subscription.destroy_all(:reader_id => reader.id)
    end    
  end
end
