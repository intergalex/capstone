json.happenings @happenings do |happening|
  json.name happening.name
  json.human_time happening.human_time
  json.description happening.description
  json.address happening.address
  json.lat happening.lat
  json.lon happening.lon
  json.url happening.url
  json.source happeing.source

end

