require 'addressable/uri'
require 'rest_client'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users'
).to_s

url2 = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users'
).to_s


url3 = Addressable::URI.new(
scheme: 'http',
host: 'localhost',
port: 3000,
path: '/users/3',
query_values: {
  'some_category[a_key]' => 'another value',
  'some_category[a_second_key]' => 'yet another value',
  'some_category[inner_inner_hash][key]' => 'value',
  'something_else' => 'aaahhhhh'
}
).to_s



# puts RestClient.get(url3)
# puts url3
puts RestClient.post(url2, user: { name: nil })
# # puts RestClient.delete(url3)
# puts RestClient.patch(url3)
