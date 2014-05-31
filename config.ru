require './web'

run Rack::URLMap.new({
  "/" => Public,
  "/reset" => Protected
})