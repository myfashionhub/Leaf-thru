Interest.delete_all

interests = [['International News', 'http://feeds.theguardian.com/theguardian/world/rss', 'http://america.aljazeera.com/content/ajam/articles.rss','http://rss.nytimes.com/services/xml/rss/nyt/World.xml'],
            ['Local News','http://nypost.com/feed/','http://www.thelmagazine.com/newyork/Rss.xml', 'http://www.amny.com/cmlink/1.2427115'],
            ['Science and Technology', 'http://news.sciencemag.org/rss/current.xml','http://feeds.popsci.com/c/34567/f/632419/index.rss' ],
            ['Politics & Activism','http://harpers.org/feed/','http://www.empowermagazine.com/feed/', 'http://www.teapartyreview.com/feed/'],
            ['Sports & Recreation', 'http://sports.espn.go.com/espn/rss/news', 'http://www.outsideonline.com/feeds/all.rss', 'http://rodeo.net/feed/'],
            ['Finance & Business', 'http://www.wired.com/feed', 'http://fortune.com/feed/', 'http://www.forbes.com/forbes/feed/'],
            ['Education',' http://www.edweek.org/ew/section/feeds/index.html', 'http://chronicle.com/section/News/6/rss', ''],
            ['Lifestyle & Culture','http://www.vanityfair.com/rss', 'https://atavist.com/feed/', 'http://www.gq.com/services/rss/feeds/latest.xml' ],
            ['Pets & Animals', 'http://pugofmyheart.wordpress.com/feed/','http://www.petage.com/feed/','http://www.vetstreet.com/rss/'],
            ['Parenting & Family', 'http://www.fitparentmagazine.com/feed/', 'http://yourteenmag.com/feed/', 'http://www.autismparentingmagazine.com/feed/']]

interests.each do |interest|
  Interest.create({topic: interest[0], url1: interest[1], url2: interest[2], url3: interest[3]});
end
