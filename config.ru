require 'rack/contrib/try_static'
require 'rack/contrib/not_found'
 
use Rack::TryStatic,
  root: "_site",
  urls: %w[/],
  try: ['index.html', '/index.html'],
  header_rules: [
    [["html"],  {'Content-Type' => 'text/html; charset=utf-8'}],
    [["css"],   {'Content-Type' => 'text/css'}],
    [["js"],    {'Content-Type' => 'text/javascript'}],
    [["png"],   {'Content-Type' => 'image/png'}],
    ["/assets", {'Cache-Control' => 'public, max-age=31536000'}],
  ]


use Rack::Auth::Basic, "U izradi..." do |username, password|
  username == 'foo' && password == 'bar'
end

run Rack::NotFound.new('_site/404.html')
