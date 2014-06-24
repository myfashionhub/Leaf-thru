

publications = [
              ['The Guardian', 'http://feeds.theguardian.com/theguardian/world/rss', 'International News'],
              ['Al Jazeera', 'http://america.aljazeera.com/content/ajam/articles.rss', 'International News'],
              ['New York Times International', 'http://rss.nytimes.com/services/xml/rss/nyt/World.xml', 'International News'],
              ['New York Post','http://nypost.com/feed/', 'Local News'],
              ['The L Magazine', 'http://www.thelmagazine.com/newyork/Rss.xml', 'Local News'],
              ['AM NY', 'http://www.amny.com/cmlink/1.2427115', 'Local News'],
              ['Science Magazine', 'http://news.sciencemag.org/rss/current.xml', 'Science and Technology'],
              ['Popular Science', 'http://feeds.popsci.com/c/34567/f/632419/index.rss', 'Science and Technology'],
              ['Science Daily', 'http://feeds.sciencedaily.com/sciencedaily','Science and Technology'],
              ["Harper's Magazine", 'http://harpers.org/feed/','Politics & Activism'],
              ["Empower Magazine", 'http://www.empowermagazine.com/feed/','Politics & Activism'],
              ['The Tea Party Review', 'http://www.teapartyreview.com/feed/', 'Politics & Activism'],
              ['ESPN Go', 'http://sports.espn.go.com/espn/rss/news', 'Sports & Recreation'],
              ['Outside Online','http://www.outsideonline.com/feeds/all.rss', 'Sports & Recreation'],
              ['Wired Magazine', 'http://www.wired.com/feed','Finance & Business'],
              ['Fortune', 'http://fortune.com/feed/','Finance & Business' ],
              ['Forbes','http://www.forbes.com/forbes/feed/','Finance & Business'],
              ['Ed Week', ' http://www.edweek.org/ew/section/feeds/index.html', 'Education'],
              ['Chronicle of Higher Education', 'http://chronicle.com/section/News/6/rss', 'Education'],
              ['ED Gov',  'http://www.ed.gov/feed', 'Education'],
              ['Vanity Fair','http://www.vanityfair.com/rss', 'Lifestyle & Culture'],
              ['The Atavist',  'https://atavist.com/feed/', 'Lifestyle & Culture'],
              ['GQ',  'http://www.gq.com/services/rss/feeds/latest.xml', 'Lifestyle & Culture'],
              ['Pug of My Heart', 'http://pugofmyheart.wordpress.com/feed/', 'Pets & Animals'],
              ['Pet Age', 'http://www.petage.com/feed/', 'Pets & Animals'],
              ['Vet Street', 'http://www.vetstreet.com/rss/','Pets & Animals'],
              ['Fit Parent',  'http://www.fitparentmagazine.com/feed/', 'Parenting & Family'],
              ['Parenting & Family', 'http://yourteenmag.com/feed/', 'Parenting & Family'],
              ['Autism Parenting Magazine', 'http://www.autismparentingmagazine.com/feed/','Parenting & Family']
            ]

publications.each do |publication|
  Publication.create({name: publication[0], url: publication[1], topic: publication[2]});
end

# 'Mashable', 'http://mashable.com/category/rss/', 'Science and Technology'
# 'TechCrunch', 'http://feeds.feedburner.com/TechCrunch/', 'Science and Technology'
