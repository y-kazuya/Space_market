
json.array! @can_re do |re|
  json.id          11
  json.title       p re[:title]
  json.start       re[:start].strftime("20%y-%m-%d")
  json.className   re[:class_name]

end
