
# Leafthru
A personalized news aggregator for busy people with style and brains.

Leafthru brings together your favorite news through your social streams, Twitter and Facebook, as well as custom RSS feeds so that you can stay up to date and ahead of the game.

![Leafthru screen shot](https://cloud.githubusercontent.com/assets/7177481/3346930/67838122-f8cf-11e3-8657-b786d98f91bf.png)

## Technical specs
  * Dependencies:
```ruby
gem 'twitter'      # Get user's timeline
gem 'googleajax'   # Parse RSS feeds
gem 'typhoeus'     # Parallel HTTP requests
gem 'geoip'        # Determine loation from IP

# Authentication
gem 'sorcery'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
```

  * The database `db/seeds.rb` is seeded with a collection of publications for the reader to choose from.
```ruby
publications = [
  ['The Guardian', 'http://feeds.theguardian.com/theguardian/world/rss', 'News'],
  ['TechCrunch', 'http://feeds.feedburner.com/TechCrunch/', 'Technology'],
  ['Vanity Fair','http://www.vanityfair.com/rss', 'Lifestyle & Culture']
]
```

### How it works:
  * Upon signing up, users can choose to connect their Twitter account with the app, as well as customize the RSS feeds they want to follow.

  * When they access the feed page, GET requests are made to two endpoints of the app to get articles from their Twitter and RSS feeds:
```ruby
  GET /feeds/twitter
  GET /feeds/rss
```

  * Twitter feed: Getting articles from an user's Twitter timeline is a two-step process.
```ruby
  # app/models/feed.rb
  def self.twitter(token, token_secret)
    article_links = Twitter::Feed.new(token, token_secret).get_timeline
    articles = Alchemy.get_articles(article_links)
  end
```      

  - First, twitter client gets posts from user's timeline. Loop through the posts and retain the URLs, excluding those containing media (e.g. Pinterest, YouTube).
  ```ruby
    # lib/twitter.rb
    def get_timeline
      tweets = client.home_timeline(options={count: 15, include_entities: true})
      links  = collect_links(tweets)
      article_links = filter_sources(links)
    end
  ```      

  - The article links are fed through the Alchemy API, which parses out the article's title and summary. These requests are made in parallel using Hydra to speed up the process.
  ```ruby
    # lib/alchemy.rb
    def self.get_articles(links)
      hydra = Typhoeus::Hydra.new

      requests = links.map do |link|
        # Building title & text requests
        hydra.queue(title_request)
        hydra.queue(text_request)        
        {
          link: link,
          title_request: title_request,
          text_request: text_request
        }        
      end
      hydra.run

      articles = self.parse_responses(requests)
      self.filter_articles(articles)
    end
  ```

  * RSS feed: Google Feed API takes URLs of XML feeds and returns article objects.   
```ruby
  # app/models/feed.rb
  def self.rss(subscriptions)
    feed_urls = subscriptions.map do |subscription|
      subscription.publication.url
    end
    articles = GoogleFeed.fetch_articles(feed_urls)
  end
```

### Future features:
- Use a rake task to collect articles from Twitter at interval and cache this response.

- Integrate with Pocket so bookmarked articles can be imported into the app and accessed offline.

- Get articles from user's Facebook feed.
