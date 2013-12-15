require 'rack/contrib/try_static'
require 'rack/contrib/not_found'

use Rack::Auth::Basic, "U izradi..." do |username, password|
  [username, password] == ['dinko', 'sifra123']
end
 
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

run Rack::NotFound.new('_site/404.html')
