require 'net/http'

namespace :sim do
  
  desc "simulate realtime bus updates"
  task :move, :url_base, :items, :needs => :environment do |t, args|

    args.with_defaults :url_base => 'localhost:3000'
    args.with_defaults :items => 10
  
    url = URI.parse("http://#{args[:url_base]}/feed/bus")
    bus = []
    args[:items].downto 0 do |i|
      post = { :id => "xref_#{i}",  :name => "bus #{i}", :district => "simulator", :lat => (30.200+(i.to_f/100)), :lng => (-97.700+(i.to_f/100)) }
      req = Net::HTTP::Post.new(url.path)
      req.set_form_data(post, ';')
	    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
	    case res
  	    when Net::HTTPSuccess, Net::HTTPRedirection
  	      puts "SUCCESS #{i} simulated create #{res.body} using #{post.to_s}" 
  	    else
  	      raise "FAILED #{i} simulated create #{post}"
	    end
      bus << post
    end
    
    1.upto(5000) do |i|
      
        req = Net::HTTP::Post.new(url.path)
	      req.set_form_data(bus[i%bus.count], ';')
  	    res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }
	    
  	    case res
    	    when Net::HTTPSuccess, Net::HTTPRedirection
    	      puts "SUCCESS #{i} simulated update #{bus[i%bus.count].to_s}"
    	    else
    	      raise "FAILED #{i} simulated update " + bus.inspect
	      end
    
        bus[i%bus.count][:lat] += rand/100 - 0.005
        bus[i%bus.count][:lng] += rand/100 - 0.005
        sleep 1
      
    end
    
  end

end