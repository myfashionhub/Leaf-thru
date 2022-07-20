# Leafthru
A personalized news aggregator.

Leafthru brings together your favorite news through your Twitter feed, using [Watson API](https://cloud.ibm.com/docs/natural-language-understanding?topic=natural-language-understanding-analyzing-webpages) to analyze text on webpages.

![Leafthru screen shot](https://cloud.githubusercontent.com/assets/7177481/3346930/67838122-f8cf-11e3-8657-b786d98f91bf.png)


### How it works:
  * Upon signing up, users can input their Twitter handle.

  * When they access the feed page, a GET request is made to `/feeds/twitter`.

  * Twitter feed: Getting articles from an user's Twitter timeline is a two-step process.
  - First, the Twitter client gets posts from user's timeline. Loop through the posts and retain the URLs, excluding those containing media (e.g. Pinterest, YouTube).
  ```ruby
    # lib/twitter.rb
    def get_timeline(username, num_results)
    end
  ```

  - The article links are fed through the Watson API ([credentials](https://console.bluemix.net/dashboard/apps)) analyze endpoint to parse out the article's title and summary. These requests are made in parallel using threads.

  * Articles are cached for 2 hours

- If the user authenticates with [Pocket](https://getpocket.com), bookmarking an article also saves the item to their Pocket account. ([Developer docs](https://getpocket.com/developer/docs/authentication)).

### Future features:
- Use a rake task to collect articles from Twitter at intervals.
