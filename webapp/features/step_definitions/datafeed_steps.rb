When /^bus named "([^\"]*)" in the "([^\"]*)" district with a id of "([^\"]*)" goes to "([^\"]*),([^\"]*)"$/ do |name, district, id, lat, lng|
  visit "/bus/at/#{id}?name=#{name}&district=#{district}&lat=#{lat}&lng=#{lng}"
end

Then /^json has an object called "([^\"]*)"$/ do |object|
  result = JSON.parse response.body
  raise "json result missing #{object} from #{result.inspect}" unless result.has_key? object
end

Then /^json has a record "([^\"]*)" in "([^\"]*)" with "([^\"]*)" value "([^\"]*)"$/ do |id, object, item, value|
  result = JSON.parse response.body
  raise "json result missing #{object} from #{result.keys.inspect}" unless result.has_key? object
  found = true if result[object][id][item] == value
  raise "did not find #{item}=#{value} in #{result[object].inspect}." unless found
end

