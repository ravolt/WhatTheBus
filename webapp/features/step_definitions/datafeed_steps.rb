When /^bus named "([^\"]*)" in the "([^\"]*)" district with a id of "([^\"]*)" goes to "([^\"]*),([^\"]*)"$/ do |name, district, id, lat, lng|
  visit "/bus/at/#{id}?name=#{name}&district=#{district}&ll=#{lat},#{lng}"
end

Then /^json has an object called "([^\"]*)"$/ do |object|
  result = JSON.parse response.body
  raise "json result missing #{object} from #{result.inspect}" unless result.has_key? object
end

Then /^json has an object "([^\"]*)" with "([^\"]*)" value "([^\"]*)"$/ do |object, item, value|
  result = JSON.parse response.body
  raise "json result missing #{object} from #{result.keys.inspect}" unless result.has_key? object
  found = false
  result[object].each do |item|
    found = true if item[item][field] == value
  end
  raise "did not find #{item}=#{value} in #{object}\\#{item}.  Review #{result[object].inspect}" unless found
end
