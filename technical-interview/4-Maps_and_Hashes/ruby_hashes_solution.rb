=begin
Time to play with Ruby hashes!
You're going to work on a hash that
stores cities by country and continent.
One is done for you - the city of Mountain
View is in the USA, which is in North America.

You need to add the cities listed below by
modifying the structure.
Then, you should print out the values specified
by looking them up in the structure.

Cities to add:
Bangalore (India, Asia)
Atlanta (USA, North America)
Cairo (Egypt, Africa)
Shanghai (China, Asia)
=end

locations = {'North America'=> {'USA'=> ['Mountain View']}}
locations['North America']['USA'] << 'Atlanta'
locations['Asia'] = {'India'=> ['Bangalore']}
locations['Asia']['China'] = ['Shanghai']
locations['Africa'] = {'Egypt'=> ['Cairo']}

=begin
Print the following (using "p").
1. A list of all cities in the USA in
alphabetic order.
2. All cities in Asia, in alphabetic
order, next to the name of the country.
In your output, label each answer with a number
so it looks like this:
1
American City
American City
2
Asian City - Country
Asian City - Country
=end

p 1
usa_sorted = locations['North America']['USA'].sort_by { |el| el }
usa_sorted.each { |city| p city }
p 2
asia_cities = []
locations['Asia'].each do |country, city|
  city_country = "#{city[0]} - #{country}"
  asia_cities << city_country
end
asia_cities.sort!
asia_cities.each { |place| p place }


