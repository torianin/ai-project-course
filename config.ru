require './web'

run Rack::URLMap.new({
  "/" => Public,
  "/admin" => Protected
})