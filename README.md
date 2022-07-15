
# Leafthru
A personalized news aggregator for busy people with style and brains.

Leafthru brings together your favorite news through your Twitter feed (using [IBM Watson Natural language understanding API](https://cloud.ibm.com/docs/services/natural-language-understanding?topic=natural-language-understanding-getting-started)) so that you can stay up to date and ahead of the game.

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
```

### How it works:
  * Upon signing up, users can input their Twitter handle.

  * When they access the feed page, GET requests are made to two endpoints of the app to get articles from their tweets: `GET /feeds/twitter`

  * Twitter feed: Getting articles from an user's Twitter timeline is a two-step process.
  - First, twitter client gets posts from user's timeline. Loop through the posts and retain the URLs, excluding those containing media (e.g. Pinterest, YouTube).
  ```ruby
    # lib/twitter.rb
    def get_timeline(username, num_results)
    end
  ```

  - The article links are fed through the Watson NPL API ([credentials](https://console.bluemix.net/dashboard/apps)) [analyze endpoint](https://www.ibm.com/watson/developercloud/natural-language-understanding/api/v1/), which parses out the article's title and summary. These requests are made in parallel using [Hydra](https://github.com/typhoeus/typhoeus) (`lib/alchemy.rb`).

  * Articles are cached for 2 hours

- If the user authenticates with [Pocket](https://getpocket.com), bookmarking an article also saves the item to their Pocket account. ([Developer docs](https://getpocket.com/developer/docs/authentication)).

### Future features:
- Use a rake task to collect articles from Twitter at intervals.
