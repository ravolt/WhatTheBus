require 'net/http'

namespace :sim do
  
  desc "simulate realtime bus updates"
  task :move, :url_base, :items, :needs => :environment do |t, args|

    args.with_defaults :url_base => 'localhost:3000'
    args.with_defaults :items => 10
  
    url = URI.parse("http://#{args[:url_base]}/feed/bus")
    req = Net::HTTP::Post.new(url.path)
    bus = []
    args[:items].downto 0 do |i|
      post = { :id => "xref_#{i}",  :name => "bus #{i}", :district => "simulator", :lat => 30.2+(i/100), :lng => -97.7+(i/100) }
      req.set_form_data(post, ';')
	    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
	    case res
  	    when Net::HTTPSuccess, Net::HTTPRedirection
  	      puts "SUCCESS #{i} simulated create " + res.body
  	    else
  	      raise "FAILED #{i} simulated create " + post.inspect
	    end
      bus << post
    end
    
    1.upto(500) do |i|
      
	      req.set_form_data(bus[i%bus.count], ';')
  	    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
	    
  	    case res
    	    when Net::HTTPSuccess, Net::HTTPRedirection
    	      puts "SUCCESS #{i} simulated update " + res.body
    	    else
    	      raise "FAILED #{i} simulated update " + bus.inspect
  	    end
    
        bus[i%bus.count][:lat] += rand/100 - 0.005
        bus[i%bus.count][:lng] += rand/100 - 0.005
        sleep 5
      
    end
    
  end

end