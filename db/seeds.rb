publications = [
              ['The Guardian', 'http://feeds.theguardian.com/theguardian/world/rss', 'International News'],
              ['Al Jazeera', 'http://america.aljazeera.com/content/ajam/articles.rss', 'International News'],
              ['NYT International', 'http://rss.nytimes.com/services/xml/rss/nyt/World.xml', 'International News'],
              ['Reuters', 'http://feeds.reuters.com/reuters/topNews', 'International News'],
              ['BBC News', 'http://feeds.bbci.co.uk/news/world/rss.xml', 'International News'],


              ['NYT National', 'http://www.nytimes.com/services/xml/rss/nyt/National.xml', 'National News'],
              ['USA Today', 'http://rssfeeds.usatoday.com/usatoday-NewsTopStories', 'National News'],
              ['CNN', 'http://rss.cnn.com/rss/cnn_topstories.rss', 'National News'],
              ['NBC News', 'http://feeds.nbcnews.com/feeds/topstories', 'National News'],
              ['Fox News', 'http://feeds.foxnews.com/foxnews/most-popular', 'National News'],


              ['TechCrunch', 'http://feeds.feedburner.com/TechCrunch/', 'Technology'],
              ['Mashable', 'http://feeds.mashable.com/Mashable','Technology'],
              ['Wired', 'http://www.wired.com/feed', 'Technology'],
              ['Gizmodo', 'http://feeds.gawker.com/gizmodo/full', 'Technology'],
              ['CNET News', 'http://www.cnet.com/rss/news', 'Technology'],
              ['AP Technology', 'http://hosted.ap.org/lineups/TECHHEADS.rss?SITE=AP&SECTION=HOME', 'Technology'],


              ['Science Magazine', 'http://news.sciencemag.org/rss/current.xml', 'Science'],
              ['NYT Science', 'http://rss.nytimes.com/services/xml/rss/nyt/Science.xml', 'Science'],
              ['Science Daily', 'http://feeds.sciencedaily.com/sciencedaily','Science'],

              ["Daily Beast", 'http://feeds.feedburner.com/thedailybeast/articles','Politics'],
              ["Fox News Politics", 'http://feeds.foxnews.com/foxnews/politics','Politics'],
              ["USA Today Politics", 'http://rssfeeds.usatoday.com/TP-OnPolitics','Politics'],
              ['AP Politics', 'http://hosted.ap.org/lineups/POLITICSHEADS.rss?SITE=AP&SECTION=HOME', 'Politics'],
              ['HuffPost Politics', 'http://www.huffingtonpost.com/feeds/verticals/politics/index.xml', 'Politics'],
              ['NPR', 'http://www.npr.org/rss/rss.php?id=1014', 'Politics'],


              ['ESPN Go', 'http://sports.espn.go.com/espn/rss/news', 'Sports'],
              ['Yahoo Sports','http://rss.news.yahoo.com/rss/sports', 'Sports'],
              ['USA Today Sports','http://rssfeeds.usatoday.com/UsatodaycomSports-TopStories', 'Sports'],
              ['Bleacher Report','http://bleacherreport.com/articles/feed', 'Sports'],
              ['Sports Illustrated','http://rss.cnn.com/rss/si_topstories.rss', 'Sports'],


              ['USA Today Ent','http://rssfeeds.usatoday.com/usatoday-LifeTopStories', 'Entertainment'],
              ['Gawker','http://www.gawker.com/index.xml', 'Entertainment'],
              ['AP Entertainment','http://hosted.ap.org/lineups/ENTERTAINMENT.rss?SITE=AP&SECTION=HOME', 'Entertainment'],

              ['NYT Style', 'http://rss.nytimes.com/services/xml/rss/nyt/FashionandStyle.xml','Lifestyle & Culture'],
              ['LA Times Lifestyle', 'http://www.latimes.com/style/rss2.0.xml','Lifestyle & Culture'],


              ['Fortune', 'http://fortune.com/feed/','Business & Finance' ],
              ['Forbes','http://www.forbes.com/forbes/feed/','Business & Finance'],
              ['WSJ Markets','http://online.wsj.com/xml/rss/3_7031.xml','Business & Finance'],
              ['Bloomberg Markets', 'http://www.bloomberg.com/tvradio/podcast/cat_markets.xml', 'Business & Finance'],
              ['Financial Times','http://www.ft.com/rss/home/us', 'Business & Finance'],
              ['CNBC','http://www.cnbc.com/id/100003114/device/rss/rss.html', 'Business & Finance'],



              ['Ed Week', ' http://www.edweek.org/ew/section/feeds/index.html', 'Education'],
              ['Chronicle of Higher Education', 'http://chronicle.com/section/News/6/rss', 'Education'],
              ['ED Gov', 'http://www.ed.gov/feed', 'Education'],


              ['WSJ Lifestyle','http://online.wsj.com/xml/rss/3_7201.xml', 'Lifestyle & Culture'],
              ['Huffington Post','http://www.huffingtonpost.com/feeds/index.xml', 'Lifestyle & Culture'],
              ['Vanity Fair','http://www.vanityfair.com/rss', 'Lifestyle & Culture'],
              ['The Atavist',  'https://atavist.com/feed/', 'Lifestyle & Culture'],
              ['GQ',  'http://www.gq.com/services/rss/feeds/latest.xml', 'Lifestyle & Culture'],


              ['Pet Age', 'http://www.petage.com/feed/', 'Pets & Animals'],
              ['Vet Street', 'http://www.vetstreet.com/rss/','Pets & Animals'],


              ['Fit Parent',  'http://www.fitparentmagazine.com/feed/', 'Parenting & Family'],
              ['Parenting & Family', 'http://yourteenmag.com/feed/', 'Parenting & Family'],

            ]

publications.each do |publication|
  Publication.create({name: publication[0], url: publication[1], category: publication[2]});
end


