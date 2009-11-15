require 'randexp'

Factory.define :amenity do |f|
  f.sequence :name
end

Factory.define :park do |f|
  f.sequence :name
  f.latitude {360*(rand - 0.5)}
  f.longitude {180*(rand - 0.5)}
  f.address {/\d{1,10} \w+, Grand Rapids MI/.gen}
end

Factory.define :link do |f|
  f.url "http://google.com"
end