When /^bus named "([^\"]*)" in the "([^\"]*)" district with a id of "([^\"]*)" goes to "([^\"]*),([^\"]*)"$/ do |name, district, id, lat, lng|
  visit "/bus/at/#{id}?name=#{name}&district=#{district}&lat=#{lat}&lng=#{lng}"
end

When /^bus with a id of "([^\"]*)" goes to "([^\"]*),([^\"]*)"$/ do |id, lat, lng|
  visit "/bus/at/#{id}?lat=#{lat}&lng=#{lng}"
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

Given /^bus named "([^\"]*)" in the "([^\"]*)" district with a id of "([^\"]*)"$/ do |name, district, xref|
  district = District.find_or_create_by_name district
  bus = Bus.find_or_create_by_xref :name => name, :district_id => district.id, :xref => xref
  raise "did not create bus #{name}" if bus.nil?
  raise "did not set bus data" unless bus.name == name
end
