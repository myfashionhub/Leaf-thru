
##Leafthru
A personalised news aggregator for busy people with style and brains.

## Intro
Scrambling to find relevant news in the morning?

Want to know what your friends are reading during the day?

Need to win that argument with your family in the evening?

Leafthru brings together your favorite news through your social streams, Twitter and Facebook, as well as custom RSS feeds so that you can stay up to date and ahead of the game.

##Resources & Documentation:
  * Framework: `'rails', '4.1.1'
  `
  * Leafthru utilized the [Twitter API gem](https://github.com/sferik/twitter), [Google Feed API](https://developers.google.com/feed/v1/?csw=1) and [Alchemy API](http://www.alchemyapi.com/api/) for its main functionality. Google Feed API is used to pull news from multiple publications' RSS feeds (using javascript, getting data in json). The Twitter gem assists in obtain article urls from the reader's Twitter feed and Alchemy is used to extract title and text from those urls.

  * We use [omniauth](https://github.com/intridea/omniauth), [omniauth-witter](https://github.com/arunagw/omniauth-twitter) and [omniauth-facebook](https://github.com/mkdynamic/omniauth-facebook) for authentication and [Sorcery](https://github.com/NoamB/sorcery) for validation.

  * The front-end is built with Rails built-in SASS and JQuery gems, as well as [Jquery UI](https://github.com/joliss/jquery-ui-rails) and [Font Awesome](http://fortawesome.github.io/Font-Awesome/icons/).

  * The database `db/seeds.rb` is seeded with a collectionn of publication RSS feed URLs for the reader to choose from.

Developed by [Nessa Nguyen](http://nessanguyen.com), Paul Gasbarra & Rebecca Strong.




