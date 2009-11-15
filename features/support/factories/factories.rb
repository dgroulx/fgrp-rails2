Factory.define :amenity do |f|
  f.sequence :name
end

Factory.define :park do |f|
  f.sequence :name
end

Factory.define :link do |f|
  f.url "http://google.com"
end