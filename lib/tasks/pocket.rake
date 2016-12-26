require 'pocket'

namespace :pocket do
  task :save_to_pocket => :environment do
    Reader.all.each do |reader|
      next if !reader.pocket_token.present?

      client = Pocket::Client.new({
        consumer_key: ENV['LT_POCKET_KEY'],
        access_token: reader.pocket_token
      })

      Bookmark.where(reader_id: reader.id).each do |bookmark|
        puts "Bookmark #{bookmark.id} has no article"
        next if bookmark.article.nil?

        article = bookmark.article
        response = client.add(url: article.url) if article.url.present?

        if response['status'] == 1
          item = response['item']
          bookmark.update(pocket_id: item['item_id'])
          puts "Successfully save to Pocket #{item['normal_url']}"
        end
      end
    end
  end
end
