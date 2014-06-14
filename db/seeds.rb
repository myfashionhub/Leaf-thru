# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

interests = ['International News', 'Local News', 'Science and Technology',
'Politics & Activism', 'Sports & Recreation', 'Finance & Business', 'Education',
'Lifestyle - Culture', 'Pets & Animals','Parenting & Family']

interests.each do |interest|
  Interest.create({topic: interest});
end
